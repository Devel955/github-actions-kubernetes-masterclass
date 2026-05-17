# Design Decisions

## Why Docker Compose

Compose keeps the EC2 deployment simple and easy to explain. It is a good first production-style target before moving the same app to Kubernetes.

## Why Kubernetes

Kubernetes demonstrates rollout control, health checks, service discovery, namespaces, and scaling.

## Why Helm

Helm keeps the Kubernetes configuration reusable while allowing different replica counts and image tags per environment.

## Why GitOps Image Bump

The pipeline writes the desired image tag back to Git. That makes releases traceable and gives Argo CD or a human operator one clear source of truth.

## Why HPA

The backend is the service most likely to need horizontal scaling, so HPA is attached there first.

## Why Canary Ingress

Canary routing reduces release risk by sending only part of the traffic to a new backend version.

## Why Trivy And Go Security Checks

Security checks run before deployment so vulnerable images or dependencies are caught early.
