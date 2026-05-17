# SkillPulse - DevOps Delivery Platform

SkillPulse is a small three-tier learning tracker used to demonstrate a complete DevOps workflow around a real application. The app is intentionally simple: the important work is the automation around it.

This repository shows how a code change can move through CI, security checks, container builds, GitOps-ready deployment files, Kubernetes environments, and rollout validation.

---

## What Was Built

### Application

- Frontend: HTML, CSS, JavaScript served by Nginx
- Backend: Go API using Gin
- Database: MySQL 8.4 with seed data
- Runtime: Docker Compose locally, Kubernetes for cluster deployment

### DevOps Improvements

- GitHub Actions CI for build, lint, security, and image publishing
- Docker image tagging with commit SHA for traceable releases
- Docker Compose deployment path for EC2
- Kubernetes manifests for local `kind`
- Helm chart with `dev`, `stg`, and `prd` values
- GitOps image tag bump workflow for Helm values
- HPA manifest for backend autoscaling
- NGINX canary ingress manifest
- Backup and restore scripts for MySQL
- AIOps/log collection scripts for troubleshooting
- Architecture and decision documentation

---

## Architecture

```text
Developer
  -> GitHub
  -> GitHub Actions CI
  -> Docker image build and scan
  -> Docker Hub image push
  -> GitOps image tag update
  -> Helm / Kubernetes desired state
  -> SkillPulse frontend, backend, and MySQL
```

Local traffic flow:

```text
Browser -> Nginx frontend -> Go backend -> MySQL
```

Kubernetes traffic flow:

```text
Ingress / NodePort -> frontend Service -> backend Service -> mysql StatefulSet
```

---

## CI/CD

The CI workflow runs on pushes to `main` and can also be started manually.

It performs:

- secret scanning
- Dockerfile linting
- Go dependency and vulnerability checks
- SAST scan
- Docker image build
- Trivy image scan
- optional Docker Hub push when `DEPLOY_ENABLED=true`

The CD workflow deploys to EC2 with Docker Compose after CI succeeds and `DEPLOY_ENABLED=true`.

The GitOps workflow updates Helm image tags after CI succeeds, so Argo CD or a manual Helm deployment can sync the new version.

---

## Run Locally

Create `.env` from the example:

```bash
cp .env.example .env
```

Run the app:

```bash
docker compose up -d --build
```

Open:

```text
http://localhost
http://localhost:8080/health
http://localhost:8080/metrics
```

Stop:

```bash
docker compose down -v
```

---

## Run On Kubernetes

For the original manifest path:

```bash
make up
make status
make logs
make down
```

For environment deployment scripts:

```bash
bash scripts/deploy-env.sh dev
bash scripts/verify-k8s-rollout.sh dev
```

For Helm:

```bash
helm template skillpulse helm/skillpulse -f helm/skillpulse/values-dev.yaml
helm upgrade --install skillpulse-dev helm/skillpulse -f helm/skillpulse/values-dev.yaml -n skillpulse-dev --create-namespace
```

---

## Multi-Environment Layout

```text
k8s/dev      -> skillpulse-dev namespace
k8s/stg      -> skillpulse-stg namespace
k8s/prd      -> skillpulse-prd namespace
helm/        -> reusable Helm chart and environment values
scripts/     -> deploy, verify, backup, restore helpers
aiops/       -> log analysis helper
observability/ -> log collection and health checks
```

---

## Reliability

- Health endpoint: `/health`
- Metrics endpoint: `/metrics`
- Kubernetes liveness and readiness probes
- backend HPA manifest
- canary ingress manifest
- rollout verification script

---

## Evidence Checklist

Capture real screenshots from this repository and place them in `screenshots/`.

- `01-project-structure.png`
- `02-docker-compose-running.png`
- `03-backend-api-working.png`
- `04-frontend-working.png`
- `05-ci-pipeline-success.png`
- `06-security-scan-output.png`
- `07-k8s-dev-running.png`
- `08-k8s-multi-env.png`
- `09-helm-template-output.png`
- `10-gitops-image-bump.png`
- `11-hpa-status.png`
- `12-canary-ingress.png`
- `13-backup-restore.png`
- `14-aiops-report.png`

Do not use screenshots from another repository. The proof should come from this repo's Actions runs, local Docker run, and Kubernetes commands.

---

## Author

Anand Sen
