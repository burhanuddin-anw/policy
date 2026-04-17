variable "allowed_locations" {
  description = "List of allowed Azure regions for resource deployment"
  type        = list(string)
  default     = ["uaenorth"]
}

variable "allowed_resource_types" {
  description = "List of allowed Azure resource types"
  type        = list(string)
  default = [
    "Microsoft.Resources/subscriptions/resourceGroups",
    "Microsoft.Storage/storageAccounts",
    "Microsoft.Network/virtualNetworks",
    "Microsoft.Network/networkSecurityGroups",
    "Microsoft.Compute/virtualMachines",
    "Microsoft.ContainerService/managedClusters",
    "Microsoft.Sql/servers",
    "Microsoft.Sql/servers/databases",
    "Microsoft.KeyVault/vaults",
    "Microsoft.ApplicationInsights/components",
    "Microsoft.Insights/components",
    "Microsoft.OperationalInsights/workspaces",
    "Microsoft.Web/serverFarms",
    "Microsoft.Web/sites",
    "Microsoft.Network/publicIPAddresses",
    "Microsoft.Network/loadBalancers",
    "Microsoft.Network/applicationGateways",
    "Microsoft.Compute/availabilitySets",
    "Microsoft.Compute/disks"
  ]
}

variable "required_tags" {
  description = "List of required tags for all resources"
  type        = list(string)
  default     = ["Environment", "Owner", "CostCenter", "Project"]
}

variable "naming_prefixes" {
  description = "List of allowed naming prefixes for resources"
  type        = list(string)
  default     = ["rg-rm1-", "vnet-rm1-", "aks-rm1-"]
}

variable "policy_config" {
  description = "Common policy configuration"
  type = object({
    policy_type = string
    mode        = string
  })
  default = {
    policy_type = "Custom"
    mode        = "Indexed"
  }
}

variable "allowed_locations_config" {
  description = "Configuration for allowed locations policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-allowed-locations"
    display_name = "RM1 - Allowed Locations"
    description  = "Restricts resource deployment to allowed regions"
  }
}

variable "allowed_resource_types_config" {
  description = "Configuration for allowed resource types policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-allowed-resource-types"
    display_name = "RM1 - Allowed Resource Types"
    description  = "Restricts deployment to specific allowed Azure resource types including resource groups"
  }
}

variable "naming_convention_config" {
  description = "Configuration for naming convention policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-naming-convention"
    display_name = "RM1 - Naming Convention"
    description  = "Enforces naming conventions with approved prefixes for resources"
  }
}

variable "required_tags_config" {
  description = "Configuration for required tags policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-required-tags"
    display_name = "RM1 - Required Tags"
    description  = "Requires specific tags to be applied to all resources"
  }
}

variable "tag_inheritance_config" {
  description = "Configuration for tag inheritance policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-tag-inheritance"
    display_name = "RM1 - Tag Inheritance"
    description  = "Inherits tags from resource group to resources using Modify effect"
  }
}
