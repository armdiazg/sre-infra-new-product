# sre-infra-baseline

**Baseline infrastructure repository** for the **SRE Agent Platform**.

This repo is a clean, parameterized template following the **Thomson Reuters InfraAutomation** pattern.
Clone or fork it to start new FSI infrastructure projects — then configure the variables for your project.

---

## Quick start

1. **Fork this repo** to your GitHub org as `<your-org>/sre-infra`
2. **Set GitHub Secrets** (see table below)
3. **Edit `terraform.tfvars`** or set `TF_VAR_*` environment variables for your project:
   - `application_name` — short app identifier (e.g. `tracker`)
   - `address_space` — VNet CIDR (e.g. `10.10.0.0/16`)
   - `subnet_prefix` — Subnet CIDR (e.g. `10.10.1.0/24`)
4. **Deploy baseline network**:
   ```
   gh workflow run deploy.yml -f working_directory=Terraform/Environments/Network/us_nonprod
   ```
5. **Deploy infrastructure baseline**:
   ```
   gh workflow run deploy.yml -f working_directory=Terraform/Environments/Infrastructure/us_nonprod
   ```
6. **Connect to SRE Agent Platform** — point `selectedRepo` at your fork

---

## Repository Layout

```
sre-infra-baseline/
├── Terraform/
│   ├── Environments/
│   │   ├── Infrastructure/
│   │   │   ├── us_nonprod/        <- Workspace: non-prod compute resources
│   │   │   │   ├── main.tf        <- Provider, backend, baseline Resource Group
│   │   │   │   ├── variables.tf   <- Shared variables (set application_name here)
│   │   │   │   ├── locals.tf      <- Naming + FSI mandatory tags
│   │   │   │   ├── outputs.tf
│   │   │   │   └── {service}.tf   <- Agent-generated (one file per VM/service)
│   │   │   └── us_prod/           <- Production (+ mandatory CanNotDelete lock)
│   │   └── Network/
│   │       ├── us_nonprod/        <- Workspace: VNet + Subnets (parameterized CIDRs)
│   │       │   └── vnet-baseline.tf
│   │       └── us_prod/
│   └── Modules/
│       ├── TrackerCore/           <- Reusable VM + NIC module (TR pattern)
│       └── azure-tagged-rg/      <- Reusable tagged Resource Group
├── .sre-agent/
│   └── repo-index.json            <- Machine-readable workspace map (agent navigation)
└── .github/workflows/
    ├── deploy.yml                 <- Triggered by SRE Agent Platform
    ├── destroy.yml                <- Rollback workflow
    └── validate.yml               <- PR validation (no Azure creds needed)
```

---

## Adding a new VM

The SRE Agent Platform generates this automatically. For manual adds:

```hcl
# Terraform/Environments/Infrastructure/us_nonprod/vm-myapp-worker-eus.tf

module "myapp_worker_eus_core" {
  source = "../../../Modules/TrackerCore"

  resource_name        = "vm-myapp-worker-eus"
  vm_size              = "Standard_DC2as_v5"
  admin_username       = "azureuser"
  subnet_id            = "<default_subnet_id from Network/us_nonprod outputs>"
  admin_ssh_public_key = var.admin_ssh_public_key
  location             = var.location
  resource_group_name  = module.baseline_rg.name
  tags                 = local.mandatory_tags
}
```

**Do NOT** add `terraform {}` or `provider {}` blocks — the workspace already provides them.

---

## Workspace symbols

Every `.tf` file you add to `Infrastructure/us_nonprod` automatically inherits:

| Symbol | Value |
|--------|-------|
| `var.location` | Azure region |
| `var.environment` | `nonprod` / `prod` |
| `var.application_name` | Your app identifier |
| `local.mandatory_tags` | 8 FSI-required tags |
| `local.resource_group_name` | `rg-{app}-{env}-{region_short}` |
| `module.baseline_rg.name` | Target Resource Group |
| `module.baseline_rg.id` | Target Resource Group ID |

---

## GitHub Actions Secrets

| Secret | Purpose |
|--------|---------|
| `AZURE_CLIENT_ID` | Service principal app ID |
| `AZURE_CLIENT_SECRET` | Service principal password |
| `AZURE_TENANT_ID` | Azure AD tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Target subscription ID |
| `TF_BACKEND_STORAGE_ACCOUNT` | Azure Storage Account for Terraform state |
| `TF_SSH_PUBLIC_KEY` | SSH public key for VM admin user |

---

## FSI Compliance

All resources automatically receive `local.mandatory_tags`:

| Tag | Value |
|-----|-------|
| `Environment` | `nonprod` / `prod` |
| `Owner` | `var.owner` |
| `CostCenter` | `var.cost_center` |
| `Application` | `var.application_name` |
| `ManagedBy` | `sre-agent-platform` |
| `Compliance` | `fsi-internal` |
| `DataClass` | `var.data_classification` |
| `ProvisionedBy` | `terraform` |
