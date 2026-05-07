# Terraform/Environments/Network/us_nonprod/main.tf
#
# Network workspace — VNet, Subnets, NSGs.
# Outputs vnet_id and default_subnet_id for use by Infrastructure workspace.

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
    key                 = "network-us_nonprod.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "baseline_rg" {
  source   = "../../../Modules/azure-tagged-rg"
  name     = local.resource_group_name
  location = var.location
  tags     = local.mandatory_tags
}
