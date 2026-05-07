# outputs.tf — Network workspace

output "resource_group_name" {
  description = "Name of the network Resource Group."
  value       = module.baseline_rg.name
}

output "vnet_id" {
  description = "Resource ID of the baseline Virtual Network."
  value       = azurerm_virtual_network.baseline.id
}

output "vnet_name" {
  description = "Name of the baseline Virtual Network."
  value       = azurerm_virtual_network.baseline.name
}

output "default_subnet_id" {
  description = "Resource ID of the default subnet — use as subnet_id input for TrackerCore VMs."
  value       = azurerm_subnet.default.id
}
