set -e

ENV=${1:-dev}
NAMESPACE="skillpulse-$ENV"

echo "Verifying rollout in namespace: $NAMESPACE"

kubectl rollout status deployment/backend -n "$NAMESPACE" --timeout=120s
kubectl rollout status deployment/frontend -n "$NAMESPACE" --timeout=120s
kubectl rollout status statefulset/mysql -n "$NAMESPACE" --timeout=120s

echo ""
echo "Pod Status:"
kubectl get pods -n "$NAMESPACE"

echo ""
echo "Kubernetes rollout health check PASSED for $ENV"
