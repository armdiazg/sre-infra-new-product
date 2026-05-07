# Terraform/Modules/TrackerCore/variables.tf

variable "resource_name" {
  description = "VM name. Follows TR naming: vm-{app}-{purpose}-{region_short}."
  type        = string
}

variable "vm_size" {
  description = "Azure VM SKU (e.g. Standard_DC2as_v5, Standard_D2s_v3)."
  type        = string
}

variable "admin_username" {
  description = "Local administrator username."
  type        = string
  default     = "azureuser"
}

variable "subnet_id" {
  description = "Subnet resource ID to attach the NIC to."
  type        = string
}

variable "location" {
  description = "Azure region. Pass var.location from the caller workspace."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name. Pass module.baseline_rg.name from the caller workspace."
  type        = string
}

variable "tags" {
  description = "Tag map. Pass local.mandatory_tags from the caller workspace."
  type        = map(string)
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the admin user. Set via TF_VAR_admin_ssh_public_key in CI."
  type        = string
  sensitive   = true
}
