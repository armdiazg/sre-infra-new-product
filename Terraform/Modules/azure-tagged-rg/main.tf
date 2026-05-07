# azure-tagged-rg/main.tf
# Reusable module: creates an Azure Resource Group with mandatory FSI tags.

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
