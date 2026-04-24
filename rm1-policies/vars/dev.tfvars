allowed_locations = ["uaenorth"]

allowed_resource_types = [
  "Microsoft.Resources/subscriptions/resourceGroups",
  "Microsoft.Authorization/policyDefinitions",
  "Microsoft.Authorization/policySetDefinitions",
  "Microsoft.Authorization/policyAssignments",
  "Microsoft.Storage/storageAccounts",
  "Microsoft.Storage/storageAccounts/blobServices",
  "Microsoft.Storage/storageAccounts/fileservices",
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