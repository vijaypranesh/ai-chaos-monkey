#!/bin/bash
set -e

echo "⚔️ Welcome to the Autonomous SRE Arena Setup ⚔️"

echo "1. Checking prerequisites..."
command -v kind >/dev/null 2>&1 || { echo >&2 "I require 'kind' but it's not installed. Aborting."; exit 1; }
command -v kubectl >/dev/null 2>&1 || { echo >&2 "I require 'kubectl' but it's not installed. Aborting."; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo >&2 "I require 'python3' but it's not installed. Aborting."; exit 1; }

echo "2. Creating Kubernetes cluster 'k8s-arena' (this may take a minute)..."
# Check if cluster exists
if kind get clusters | grep -q "k8s-arena"; then
    echo "Cluster 'k8s-arena' already exists."
else
    kind create cluster --name k8s-arena
fi

echo "3. Applying Kubernetes deployment..."
kubectl apply -f deployment.yaml

echo "4. Setting up Python virtual environment for the Dashboard..."
cd dashboard
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

echo "5. Starting the Live Dashboard on http://localhost:3006..."
echo "Open http://localhost:3006 in your browser to watch the live Pod status!"
echo "Press Ctrl+C to stop the dashboard."
uvicorn main:app --host 0.0.0.0 --port 3006
