# Terraform/Environments/Network/us_nonprod/vnet-baseline.tf
#
# Baseline Virtual Network and default subnet.
# CIDRs are controlled by var.address_space and var.subnet_prefix — set them
# in a tfvars file or via TF_VAR_* environment variables.

resource "azurerm_virtual_network" "baseline" {
  name                = "vnet-${var.application_name}-${var.environment}-${local.region_short}"
  location            = var.location
  resource_group_name = module.baseline_rg.name
  address_space       = [var.address_space]
  tags                = local.mandatory_tags
}

resource "azurerm_subnet" "default" {
  name                 = "default-subnet"
  resource_group_name  = module.baseline_rg.name
  virtual_network_name = azurerm_virtual_network.baseline.name
  address_prefixes     = [var.subnet_prefix]
}
