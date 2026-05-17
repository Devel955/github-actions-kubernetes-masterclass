# Architecture

SkillPulse is a three-tier app with a DevOps delivery layer around it.

## Application Flow

```text
Browser -> Frontend (Nginx) -> Backend (Go/Gin) -> MySQL
```

The frontend proxies API calls to the backend. The backend reads database settings from environment variables and exposes `/health` and `/metrics` for operations.

## Delivery Flow

```text
Git push -> GitHub Actions CI -> Docker build and scan -> image tag -> deployment path
```

There are two deployment paths:

- Docker Compose on EC2 for a simple server deployment
- Helm/Kubernetes for GitOps-style environments

## Kubernetes Flow

```text
Namespace -> Services -> Deployments -> StatefulSet -> PVC
```

Environment separation is handled through namespaces and Helm values:

- `skillpulse-dev`
- `skillpulse-stg`
- `skillpulse-prd`

## Reliability Hooks

- liveness probes
- readiness probes
- rollout verification script
- HPA manifest
- canary ingress manifest

## Observability Hooks

- backend `/metrics`
- Prometheus config
- log collection scripts
- AIOps report helper
