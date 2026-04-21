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
    "Microsoft.Authorization/policyDefinitions",
    "Microsoft.Authorization/policySetDefinitions",
    "Microsoft.Authorization/policyAssignments",
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

variable "allowed_vm_skus" {
  description = "List of allowed VM SKUs to control costs"
  type        = list(string)
  default = [
    "Standard_B1s",
    "Standard_B2s",
    "Standard_B2ms",
    "Standard_D2s_v3",
    "Standard_D4s_v3",
    "Standard_D8s_v3"
  ]
}

variable "allowed_storage_skus" {
  description = "List of allowed storage account SKUs"
  type        = list(string)
  default = [
    "Standard_LRS",
    "Standard_ZRS",
    "Standard_GRS"
  ]
}

variable "high_cost_regions" {
  description = "List of high-cost regions to restrict"
  type        = list(string)
  default = [
    "eastus2",
    "westus2",
    "westeurope",
    "northeurope",
    "japaneast",
    "southeastasia"
  ]
}
