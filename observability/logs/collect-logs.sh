#!/bin/bash
set -e

ENV=${1:-dev}
NAMESPACE="skillpulse-$ENV"
OUT_DIR="observability/logs/output/$ENV"

mkdir -p "$OUT_DIR"

echo "Collecting logs from namespace: $NAMESPACE"

kubectl logs -n "$NAMESPACE" deployment/backend --tail=200 > "$OUT_DIR/backend.log" || true
kubectl logs -n "$NAMESPACE" deployment/frontend --tail=200 > "$OUT_DIR/frontend.log" || true
kubectl logs -n "$NAMESPACE" statefulset/mysql --tail=200 > "$OUT_DIR/mysql.log" || true
kubectl get pods -n "$NAMESPACE" -o wide > "$OUT_DIR/pods-status.txt"
kubectl get events -n "$NAMESPACE" --sort-by=.lastTimestamp > "$OUT_DIR/events.txt"

echo "Logs collected in: $OUT_DIR"
