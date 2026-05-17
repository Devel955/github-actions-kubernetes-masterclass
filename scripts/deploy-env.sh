#!/bin/bash
set -e

ENV=$1

if [[ "$ENV" != "dev" && "$ENV" != "stg" && "$ENV" != "prd" ]]; then
  echo "Usage: ./scripts/deploy-env.sh dev|stg|prd"
  exit 1
fi

NAMESPACE="skillpulse-$ENV"

echo "Deploying SkillPulse to $ENV environment..."

kubectl apply -f k8s/$ENV/namespace.yaml
kubectl apply -f k8s/base/mysql.yaml -n $NAMESPACE
kubectl apply -f k8s/base/backend.yaml -n $NAMESPACE
kubectl apply -f k8s/base/frontend.yaml -n $NAMESPACE

echo "Deployment completed for $ENV"

kubectl get pods -n $NAMESPACE
kubectl get svc -n $NAMESPACE
