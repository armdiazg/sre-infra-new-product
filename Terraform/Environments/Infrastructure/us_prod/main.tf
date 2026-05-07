# Terraform/Environments/Infrastructure/us_prod/main.tf
#
# Infrastructure workspace — compute resources (VMs, SQL servers, etc.)
# Thomson Reuters InfraAutomation pattern:
#   - This file: provider + backend + baseline Resource Group
#   - Each service gets its own .tf file calling TrackerCore module
#   - Service files do NOT repeat terraform{} or provider{} blocks
#
# Agent-generated service files inherit:
#   var.location, var.environment, local.mandatory_tags, module.baseline_rg.name

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Remote state — configure storage_account_name at init time:
  #   terraform init -backend-config="storage_account_name=<YOUR_TF_BACKEND>"
  backend "azurerm" {
    resource_group_name = "rg-tfstate-eus"
    container_name      = "tfstate"
    key                 = "infra-us_prod.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

# ── Baseline Resource Group ─────────────────────────────────────────────────
# All agent-generated service files deploy their resources into this RG.

module "baseline_rg" {
  source   = "../../../Modules/azure-tagged-rg"
  name     = local.resource_group_name
  location = var.location
  tags     = local.mandatory_tags
}
# Production: CanNotDelete lock is mandatory — no toggle.
resource "azurerm_management_lock" "rg_lock" {
  name       = "${local.resource_group_name}-nodelete"
  scope      = module.baseline_rg.id
  lock_level = "CanNotDelete"
  notes      = "FSI Compliance: Prod RG cannot be deleted without explicit unlock and dual approval."
}
