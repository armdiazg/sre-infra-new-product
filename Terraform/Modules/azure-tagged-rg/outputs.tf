# azure-tagged-rg/outputs.tf

output "id" {
  description = "Resource Group resource ID."
  value       = azurerm_resource_group.this.id
}

output "name" {
  description = "Resource Group name."
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Azure region where the Resource Group was created."
  value       = azurerm_resource_group.this.location
}
