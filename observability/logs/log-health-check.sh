#!/bin/bash
set -e

ENV=${1:-dev}
LOG_DIR="observability/logs/output/$ENV"

echo "Checking logs for common issues..."

grep -RniE "error|failed|panic|exception|denied|timeout|crash|unhealthy" "$LOG_DIR" || echo "No obvious errors found."

echo
echo "Recent Kubernetes events:"
tail -n 20 "$LOG_DIR/events.txt"
