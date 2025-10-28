# AKS Infrastructure for KubeCon NA 2025

This Bicep template creates a production-ready Azure Kubernetes Service (AKS) cluster with the following features:

## Features

- **AKS Cluster** with latest Kubernetes version (1.30.5)
- **System Node Pool** with auto-scaling (1-5 nodes)
- **User Node Pool** for application workloads (1-10 nodes)
- **Azure CNI** networking with Azure Network Policy
- **Workload Identity** enabled for secure access to Azure resources
- **OIDC Issuer** for external identity integration
- **Key Vault CSI Driver** for secrets management
- **Azure Policy** add-on for governance
- **Auto-upgrade** enabled for cluster and node OS
- **Azure Monitor** metrics collection

## Prerequisites

1. Azure CLI installed and configured
2. Bicep CLI installed

## Deployment

### 1. Update Parameters (Optional)

You can customize the deployment by editing `infra.bicepparam`:
- Change cluster name, location, or VM sizes
- Modify node counts or Kubernetes version
- Update tags as needed

### 2. Create Resource Group

```bash
az group create --name rg-kubeconna2025 --location eastus
```

### 4. Deploy Infrastructure

```bash
az deployment group create \
  --resource-group rg-kubeconna2025 \
  --template-file infra.bicep \
  --parameters infra.bicepparam
```

### 5. Get Cluster Credentials

```bash
az aks get-credentials \
  --resource-group rg-kubeconna2025 \
  --name aks-kubeconna2025
```

### 6. Verify Deployment

```bash
kubectl get nodes
kubectl get pods --all-namespaces
```

## Configuration Details

### Node Pools

- **System Pool**: Dedicated for system components (kube-system pods)
  - VM Size: Standard_D2s_v3
  - Auto-scaling: 1-5 nodes
  - Taints: `CriticalAddonsOnly=true:NoSchedule`

- **User Pool**: For application workloads
  - VM Size: Standard_D4s_v3
  - Auto-scaling: 1-10 nodes

### Networking

- **Service CIDR**: 10.96.0.0/16
- **DNS Service IP**: 10.96.0.10
- **Network Plugin**: Azure CNI
- **Network Policy**: Azure

### Security

- **RBAC**: Enabled
- **Workload Identity**: Enabled
- **Private Cluster**: Disabled (for demo purposes)
- **Auto-upgrade**: Stable channel

## Clean Up

```bash
az group delete --name rg-kubeconna2025 --yes --no-wait
```

## Customization

To customize the deployment:

1. Modify parameters in `infra.bicepparam`
2. Adjust resource configurations in `infra.bicep`
3. Add additional node pools or features as needed

For production use, consider:
- Enabling private cluster
- Adding Azure Application Gateway ingress
- Configuring Azure Monitor Container Insights
- Setting up GitOps with Azure Arc or Flux
