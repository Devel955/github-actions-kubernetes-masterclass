# Screenshot Evidence Guide

Use this folder for final hackathon proof screenshots. Do not copy screenshots from another repository; capture them from this repository after each feature is working.

Already captured:

- `01-github-repo-readme.png` - GitHub repository README after the DevOps platform updates
- `02-local-validation-evidence.png` - local validation evidence from this repository
- `05-ci-pipeline-success.png` - real GitHub Actions CI success run
- `06-devsecops-success.png` - real GitHub Actions DevSecOps success run
- `10-gitops-workflow-skipped.png` - real GitOps workflow run showing expected skip while deploy is disabled

Pending after Docker Desktop/local cluster is running:

Recommended screenshots:

1. `03-docker-compose-running.png` - `docker compose ps`
2. `04-frontend-working.png` - SkillPulse UI in browser
3. `07-backend-api-working.png` - `curl http://localhost:8080/health` or `/metrics`
4. `08-k8s-dev-environment-working.png` - `kubectl get pods,svc -n skillpulse-dev`
5. `09-k8s-multi-env-all-running.png` - `kubectl get ns | grep skillpulse`
6. `11-hpa-autoscaling-working.png` - `kubectl get hpa -n skillpulse-dev`
7. `12-canary-ingress.png` - `kubectl get ingress -n skillpulse-dev`
8. `13-backup-restore.png` - backup/restore script terminal output
9. `14-aiops-log-analysis-report.png` - generated AIOps report
