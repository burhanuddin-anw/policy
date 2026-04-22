allowed_locations = ["uaenorth"]

allowed_resource_types = [
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

required_tags = ["Environment", "Owner", "CostCenter", "Project"]

naming_prefixes = ["rg-rm1-", "vnet-rm1-", "aks-rm1-"]
