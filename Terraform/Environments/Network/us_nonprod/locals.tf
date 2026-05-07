# locals.tf
# FSI naming conventions and mandatory tags.
# All resource files added to this workspace INHERIT these locals.

locals {
  # Region shortcodes
  _region_short = {
    "eastus"         = "eus"
    "eastus2"        = "eus2"
    "westus"         = "wus"
    "westus2"        = "wus2"
    "westeurope"     = "weu"
    "northeurope"    = "neu"
    "centralus"      = "cus"
    "southcentralus" = "scus"
    "uksouth"        = "uks"
    "ukwest"         = "ukw"
    "australiaeast"  = "aue"
  }

  region_short = lookup(local._region_short, var.location, replace(var.location, " ", ""))

  resource_group_name = "rg-${var.application_name}-network-${var.environment}-${local.region_short}"

  # FSI mandatory tags — inherited by all resources in this workspace
  mandatory_tags = {
    Environment   = var.environment
    Owner         = var.owner
    CostCenter    = var.cost_center
    Application   = var.application_name
    ManagedBy     = "sre-agent-platform"
    Compliance    = "fsi-internal"
    DataClass     = var.data_classification
    ProvisionedBy = "terraform"
  }
}
