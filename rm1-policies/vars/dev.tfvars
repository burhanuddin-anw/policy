allowed_locations = ["uaenorth"]

allowed_resource_types = [
  "Microsoft.Resources/subscriptions/resourceGroups",
  "Microsoft.Authorization/policyDefinitions",
  "Microsoft.Authorization/policySetDefinitions",
  "Microsoft.Authorization/policyAssignments",
  "Microsoft.Storage/storageAccounts",
  "Microsoft.Network/virtualNetworks",
  "Microsoft.Network/networkInterfaces",
  "Microsoft.Network/networkSecurityGroups",
  "Microsoft.Compute/virtualMachines",
  "Microsoft.Compute/sshPublicKeys",
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

required_tags = ["Environment", "Owner", "CostCenter", "Project"]

naming_prefixes = ["rg-rm1-", "vnet-rm1-", "aks-rm1-"]

policy_config = {
  policy_type = "Custom"
  mode        = "Indexed"
}

allowed_locations_config = {
  name         = "rm1-allowed-locations"
  display_name = "RM1 - Allowed Locations"
  description  = "Restricts resource deployment to allowed regions"
}

allowed_resource_types_config = {
  name         = "rm1-allowed-resource-types"
  display_name = "RM1 - Allowed Resource Types"
  description  = "Restricts deployment to specific allowed Azure resource types including resource groups"
}

naming_convention_config = {
  name         = "rm1-naming-convention"
  display_name = "RM1 - Naming Convention"
  description  = "Enforces naming conventions with approved prefixes for resources"
}

required_tags_config = {
  name         = "rm1-required-tags"
  display_name = "RM1 - Required Tags"
  description  = "Requires specific tags to be applied to all resources"
}

tag_inheritance_config = {
  name         = "rm1-tag-inheritance"
  display_name = "RM1 - Tag Inheritance"
  description  = "Inherits tags from resource group to resources using Modify effect"
}

allowed_vm_skus_config = {
  name         = "rm1-allowed-vm-skus"
  display_name = "RM1 - Allowed VM SKUs"
  description  = "Restricts VM SKUs to control costs by allowing only cost-effective sizes"
}

allowed_storage_skus_config = {
  name         = "rm1-allowed-storage-skus"
  display_name = "RM1 - Allowed Storage SKUs"
  description  = "Restricts storage account SKUs to cost-effective tiers"
}

restrict_high_cost_regions_config = {
  name         = "rm1-restrict-high-cost-regions"
  display_name = "RM1 - Restrict High-Cost Regions"
  description  = "Prevents resource deployment in expensive Azure regions"
}

cost_allocation_tags_config = {
  name         = "rm1-cost-allocation-tags"
  display_name = "RM1 - Cost Allocation Tags"
  description  = "Requires cost center and project tags for proper cost allocation"
}

allowed_vm_skus = [
  "Standard_B1s",
  "Standard_B2s",
  "Standard_B2ms",
  "Standard_D2s_v3",
  "Standard_D4s_v3",
  "Standard_D8s_v3"
]

allowed_storage_skus = [
  "Standard_LRS",
  "Standard_ZRS",
  "Standard_GRS"
]

high_cost_regions = [
  "eastus2",
  "westus2",
  "westeurope",
  "northeurope",
  "japaneast",
  "southeastasia"
]