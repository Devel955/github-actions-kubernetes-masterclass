# Screenshot Evidence Guide

Use this folder for final hackathon proof screenshots. Do not copy screenshots from another repository; capture them from this repository after each feature is working.

Recommended screenshots:

1. `01-project-structure.png` - repo folders for `.github`, `helm`, `k8s`, `scripts`, `docs`, `aiops`, `observability`
2. `02-docker-compose-running.png` - `docker compose ps`
3. `03-backend-api-working.png` - `curl http://localhost:8080/health` or `curl http://localhost/health`
4. `04-frontend-working.png` - SkillPulse UI
5. `05-ci-pipeline-success.png` - GitHub Actions CI success
6. `06-trivy-security-scan.png` - Trivy scan step
7. `07-k8s-dev-environment-working.png` - `kubectl get pods,svc -n skillpulse-dev`
8. `08-k8s-multi-env-all-running.png` - `kubectl get ns | grep skillpulse`
9. `09-helm-multi-env-values.png` - `helm template skillpulse helm/skillpulse -f helm/skillpulse/values-dev.yaml`
10. `10-gitops-image-bump.png` - CD GitOps workflow or image tag bump commit
11. `11-hpa-autoscaling-working.png` - `kubectl get hpa -n skillpulse-dev`
12. `12-canary-ingress.png` - `kubectl get ingress -n skillpulse-dev`
13. `13-backup-restore.png` - backup/restore script terminal output
14. `14-aiops-log-analysis-report.png` - generated AIOps report
