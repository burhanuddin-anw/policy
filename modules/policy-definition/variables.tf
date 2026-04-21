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

# Security Policies Configuration
variable "storage_https_only_config" {
  description = "Configuration for storage HTTPS only policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-storage-https-only"
    display_name = "RM1 - Storage HTTPS Only"
    description  = "Requires HTTPS traffic only for Azure Storage accounts"
  }
}

variable "storage_private_endpoints_config" {
  description = "Configuration for storage private endpoints policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-storage-private-endpoints"
    display_name = "RM1 - Storage Private Endpoints"
    description  = "Requires private endpoints for Azure Storage accounts"
  }
}

variable "diagnostic_settings_config" {
  description = "Configuration for diagnostic settings policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-diagnostic-settings"
    display_name = "RM1 - Diagnostic Settings"
    description  = "Audits resources for diagnostic settings configuration"
  }
}

# Compliance & Regulatory Policies Configuration
variable "data_encryption_config" {
  description = "Configuration for data encryption policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-data-encryption"
    display_name = "RM1 - Data Encryption"
    description  = "Requires data encryption for storage and SQL databases"
  }
}

variable "backup_protection_config" {
  description = "Configuration for backup protection policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-backup-protection"
    display_name = "RM1 - Backup Protection"
    description  = "Audits backup protection for critical resources"
  }
}

variable "data_retention_config" {
  description = "Configuration for data retention policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-data-retention"
    display_name = "RM1 - Data Retention"
    description  = "Enforces data retention policies for storage accounts"
  }
}

# Networking Policies Configuration
variable "network_security_groups_config" {
  description = "Configuration for network security groups policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-network-security-groups"
    display_name = "RM1 - Network Security Groups"
    description  = "Requires network security groups for all subnets"
  }
}

variable "keyvault_private_endpoints_config" {
  description = "Configuration for Key Vault private endpoints policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-keyvault-private-endpoints"
    display_name = "RM1 - Key Vault Private Endpoints"
    description  = "Requires private endpoints for Key Vault access"
  }
}

variable "ddos_protection_config" {
  description = "Configuration for DDoS protection policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-ddos-protection"
    display_name = "RM1 - DDoS Protection"
    description  = "Audits DDoS protection for virtual networks"
  }
}

# Cost Management Policies Configuration
variable "allowed_vm_skus_config" {
  description = "Configuration for allowed VM SKUs policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-allowed-vm-skus"
    display_name = "RM1 - Allowed VM SKUs"
    description  = "Restricts VM SKUs to control costs by allowing only cost-effective sizes"
  }
}

variable "allowed_storage_skus_config" {
  description = "Configuration for allowed Storage SKUs policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-allowed-storage-skus"
    display_name = "RM1 - Allowed Storage SKUs"
    description  = "Restricts storage account SKUs to cost-effective tiers"
  }
}

variable "restrict_high_cost_regions_config" {
  description = "Configuration for high-cost regions restriction policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-restrict-high-cost-regions"
    display_name = "RM1 - Restrict High-Cost Regions"
    description  = "Prevents resource deployment in expensive Azure regions"
  }
}

variable "cost_allocation_tags_config" {
  description = "Configuration for cost allocation tags policy"
  type = object({
    name         = string
    display_name = string
    description  = string
  })
  default = {
    name         = "rm1-cost-allocation-tags"
    display_name = "RM1 - Cost Allocation Tags"
    description  = "Requires cost center and project tags for proper cost allocation"
  }
}

# Cost Management Variables
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
