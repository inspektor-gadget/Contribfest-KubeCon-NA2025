#!/bin/bash

# Deploy applications to AKS cluster
echo "Starting AKS application deployment at $(date)"

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/
kubectl version --client

# Get AKS credentials
echo "Getting AKS credentials..."
az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --overwrite-existing

# Verify cluster connection
echo "Verifying cluster connection..."
kubectl get nodes

# List current namespaces before creation
echo "Current namespaces before creation:"
kubectl get namespaces

# Create demo namespace
echo "Creating demo namespace..."
kubectl create namespace demo-apps --dry-run=client -o yaml
kubectl create namespace demo-apps

# Verify namespace was created
echo "Verifying namespace creation..."
if kubectl get namespace demo-apps; then
    echo "✅ Namespace 'demo-apps' created successfully!"
else
    echo "❌ Failed to create namespace 'demo-apps'"
    exit 1
fi

# List all namespaces after creation
echo "All namespaces after creation:"
kubectl get namespaces

echo "Deployment script completed successfully!"
echo "Namespace creation verified at $(date)"
