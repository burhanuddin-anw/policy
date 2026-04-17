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
