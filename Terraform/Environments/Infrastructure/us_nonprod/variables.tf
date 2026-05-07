# variables.tf
# Input variables shared across all .tf files in this workspace.

variable "location" {
  description = "Azure region for resources in this workspace."
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment label used in naming and tags."
  type        = string
  default     = "nonprod"

  validation {
    condition     = contains(["nonprod", "dev", "test", "staging"], var.environment)
    error_message = "See validation block for allowed values."
  }
}

variable "application_name" {
  description = "Short application identifier (lowercase, no spaces). Set this per project."
  type        = string
  default     = "your-app"
}

variable "owner" {
  description = "Team or individual responsible for this resource (email or alias)."
  type        = string
  default     = "your-team"
}

variable "cost_center" {
  description = "Finance cost-center code for chargeback."
  type        = string
  default     = "CC-XXXX"
}

variable "data_classification" {
  description = "Data classification per FSI policy (public, internal, confidential, restricted)."
  type        = string
  default     = "internal"

  validation {
    condition     = contains(["public", "internal", "confidential", "restricted"], var.data_classification)
    error_message = "data_classification must be public, internal, confidential, or restricted."
  }
}
variable "enable_delete_lock" {
  description = "Set true to apply a CanNotDelete management lock on the Resource Group."
  type        = bool
  default     = false
}
variable "admin_ssh_public_key" {
  description = "SSH public key for VM admin user. Passed via TF_VAR_admin_ssh_public_key in CI."
  type        = string
  sensitive   = true
}
