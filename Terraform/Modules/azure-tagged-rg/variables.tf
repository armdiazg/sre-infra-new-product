# azure-tagged-rg/variables.tf

variable "name" {
  description = "Resource Group name. Must follow the TR naming convention."
  type        = string
}

variable "location" {
  description = "Azure region (e.g. eastus, westeurope)."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply. Callers must include all FSI mandatory tags."
  type        = map(string)
}
