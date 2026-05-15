#!/bin/bash

# Health Check Script
# Checks if all services are running properly

echo "🔍 Checking all services health..."

# Check Frontend
FRONTEND=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)
if [ "$FRONTEND" -eq 200 ]; then
  echo "✅ Frontend is UP (port 80)"
else
  echo "❌ Frontend is DOWN (port 80) - Status: $FRONTEND"
fi

# Check Backend
BACKEND=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health)
if [ "$BACKEND" -eq 200 ]; then
  echo "✅ Backend is UP (port 8080)"
else
  echo "❌ Backend is DOWN (port 8080) - Status: $BACKEND"
fi

# Check Docker containers
echo ""
echo "🐳 Docker Container Status:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "✅ Health check complete!"