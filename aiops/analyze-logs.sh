#!/bin/bash
set -e

ENV=${1:-dev}
LOG_DIR="observability/logs/output/$ENV"
REPORT_DIR="aiops/reports"
REPORT_FILE="$REPORT_DIR/${ENV}-aiops-report.md"

mkdir -p "$REPORT_DIR"

if [ ! -d "$LOG_DIR" ]; then
  echo "Log directory not found: $LOG_DIR"
  echo "Run: ./observability/logs/collect-logs.sh $ENV"
  exit 1
fi

ERRORS=$(grep -RniE "error|failed|panic|exception|denied|timeout|crash|unhealthy|warning" "$LOG_DIR" || true)
EVENTS=$(tail -n 30 "$LOG_DIR/events.txt" 2>/dev/null || true)
PODS=$(cat "$LOG_DIR/pods-status.txt" 2>/dev/null || true)

cat > "$REPORT_FILE" <<REPORT
# AIOps Incident Analysis Report - $ENV

## Environment
- Namespace: skillpulse-$ENV
- Generated At: $(date)

## Pod Health Snapshot

\`\`\`
$PODS
\`\`\`

## Detected Issues

\`\`\`
${ERRORS:-No critical issues detected.}
\`\`\`

## Recent Cluster Events

\`\`\`
$EVENTS
\`\`\`

## Root Cause Summary

REPORT
if echo "$ERRORS" | grep -qi "empty password"; then
cat >> "$REPORT_FILE" <<REPORT
Security risk detected: MySQL is running with an empty root password. This can lead to unauthorized access in production environments.

REPORT
elif echo "$ERRORS" | grep -qi "self signed"; then
cat >> "$REPORT_FILE" <<REPORT
Security warning: MySQL is using a self-signed certificate. For production, a trusted certificate authority should be used.

REPORT
elif echo "$EVENTS" | grep -qi "SuccessfulRescale"; then
cat >> "$REPORT_FILE" <<REPORT
System experienced autoscaling activity. Backend scaled based on CPU load and stabilized correctly. HPA is functioning as expected.

REPORT
elif echo "$ERRORS" | grep -qi "metrics API"; then
cat >> "$REPORT_FILE" <<REPORT
Historical issue detected: HPA metrics API was unavailable earlier. This has likely been resolved after metrics-server configuration.

REPORT
else
cat >> "$REPORT_FILE" <<REPORT
No major incident pattern was detected. Workloads appear stable based on the collected logs and recent Kubernetes events.

REPORT
fi

cat >> "$REPORT_FILE" <<REPORT

## Recommended Actions

- Verify all pods are Running and Ready.
- Check recent Kubernetes events before debugging application code.
- Confirm metrics-server is healthy if HPA metrics show unknown values.
- Review backend and database logs when API errors appear.
- Keep alerts connected to a valid notification contact point.

## Suggested Commands

\`\`\`bash
kubectl get pods -n skillpulse-$ENV
kubectl get events -n skillpulse-$ENV --sort-by=.lastTimestamp
kubectl logs -n skillpulse-$ENV deployment/backend --tail=100
kubectl get hpa -n skillpulse-$ENV
\`\`\`
REPORT

echo "AIOps report generated: $REPORT_FILE"
