# outputs.tf — Infrastructure workspace

output "resource_group_id" {
  description = "Resource ID of the baseline Resource Group."
  value       = module.baseline_rg.id
}

output "resource_group_name" {
  description = "Name of the baseline Resource Group."
  value       = module.baseline_rg.name
}

output "resource_group_location" {
  description = "Azure region of the Resource Group."
  value       = module.baseline_rg.location
}
