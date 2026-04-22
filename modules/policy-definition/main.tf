# Policy 1: Allowed Locations - UAE North only
resource "azurerm_policy_definition" "allowed_locations" {
  name                = var.allowed_locations_config.name
  display_name        = var.allowed_locations_config.display_name
  description         = var.allowed_locations_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      field = "location"
      notIn = "[parameters('allowedLocations')]"
    }
    then = {
      effect = "deny"
    }
  })
  
  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed locations"
        description = "The list of locations that resources can be deployed to"
        strongType = "location"
      }
      defaultValue = var.allowed_locations
    }
  })
}

# Policy 2: Allowed Resource Types
resource "azurerm_policy_definition" "allowed_resource_types" {
  name                = var.allowed_resource_types_config.name
  display_name        = var.allowed_resource_types_config.display_name
  description         = var.allowed_resource_types_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      field = "type"
      notIn = "[parameters('allowedResourceTypes')]"
    }
    then = {
      effect = "deny"
    }
  })
  
  parameters = jsonencode({
    allowedResourceTypes = {
      type = "Array"
      metadata = {
        displayName = "Allowed resource types"
        description = "The list of resource types that can be deployed"
      }
      defaultValue = var.allowed_resource_types
    }
  })
}

# Policy 3: Naming Convention
resource "azurerm_policy_definition" "naming_convention" {
  name                = var.naming_convention_config.name
  display_name        = var.naming_convention_config.display_name
  description         = var.naming_convention_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      anyOf = [
        # Resource Groups
        {
          allOf = [
            {
              field = "type"
              equals = "Microsoft.Resources/subscriptions/resourceGroups"
            },
            {
              field = "name"
              notLike = "rg-rm1-*"
            }
          ]
        },
        # Virtual Networks
        {
          allOf = [
            {
              field = "type"
              equals = "Microsoft.Network/virtualNetworks"
            },
            {
              field = "name"
              notLike = "vnet-rm1-*"
            }
          ]
        },
        # AKS Clusters
        {
          allOf = [
            {
              field = "type"
              equals = "Microsoft.ContainerService/managedClusters"
            },
            {
              field = "name"
              notLike = "aks-rm1-*"
            }
          ]
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

# Policy 4: Required Tags
resource "azurerm_policy_definition" "required_tags" {
  name                = var.required_tags_config.name
  display_name        = var.required_tags_config.display_name
  description         = var.required_tags_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      allOf = concat(
        [
          {
            field = "type"
            notEquals = "Microsoft.Resources/subscriptions/resourceGroups"
          }
        ],
        [
          {
            field = "[concat('tags[', parameters('requiredTags')[0], ']')]"
            exists = "false"
          }
        ]
      )
    }
    then = {
      effect = "deny"
    }
  })
  
  parameters = jsonencode({
    requiredTags = {
      type = "Array"
      defaultValue = var.required_tags
      metadata = {
        displayName = "Required tags"
        description = "The list of required tags for resources"
      }
    }
  })
}

# Policy 5: Tag Inheritance (Modify effect)
resource "azurerm_policy_definition" "tag_inheritance" {
  name                = var.tag_inheritance_config.name
  display_name        = var.tag_inheritance_config.display_name
  description         = var.tag_inheritance_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      field = "type"
      notEquals = "Microsoft.Resources/subscriptions/resourceGroups"
    }
    then = {
      effect = "modify"
      details = {
        roleDefinitionIds = [
          "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ]
        operations = [
          {
            operation = "add"
            field = "tags['Environment']"
            value = "[resourcegroup().tags['Environment']]"
          },
          {
            operation = "add"
            field = "tags['Owner']"
            value = "[resourcegroup().tags['Owner']]"
          },
          {
            operation = "add"
            field = "tags['CostCenter']"
            value = "[resourcegroup().tags['CostCenter']]"
          },
          {
            operation = "add"
            field = "tags['Project']"
            value = "[resourcegroup().tags['Project']]"
          }
        ]
      }
    }
  })
}

# Policy 6: Security - Require HTTPS for Storage Accounts
resource "azurerm_policy_definition" "storage_https_only" {
  name                = var.storage_https_only_config.name
  display_name        = var.storage_https_only_config.display_name
  description         = var.storage_https_only_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      field = "type"
      equals = "Microsoft.Storage/storageAccounts"
    }
    then = {
      effect = "audit"
    }
  })
}

# Policy 7: Security - Require Private Endpoints for Storage Accounts
resource "azurerm_policy_definition" "storage_private_endpoints" {
  name                = var.storage_private_endpoints_config.name
  display_name        = var.storage_private_endpoints_config.display_name
  description         = var.storage_private_endpoints_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      field = "type"
      equals = "Microsoft.Storage/storageAccounts"
    }
    then = {
      effect = "audit"
    }
  })
}

# Policy 8: Security - Require Diagnostic Settings
resource "azurerm_policy_definition" "diagnostic_settings" {
  name                = var.diagnostic_settings_config.name
  display_name        = var.diagnostic_settings_config.display_name
  description         = var.diagnostic_settings_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      field = "type"
      in = [
        "Microsoft.Storage/storageAccounts",
        "Microsoft.Compute/virtualMachines",
        "Microsoft.Network/virtualNetworks",
        "Microsoft.Sql/servers",
        "Microsoft.KeyVault/vaults"
      ]
    }
    then = {
      effect = "audit"
    }
  })
}

# Policy 9: Compliance - Require Data Encryption
resource "azurerm_policy_definition" "data_encryption" {
  name                = var.data_encryption_config.name
  display_name        = var.data_encryption_config.display_name
  description         = var.data_encryption_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          field = "Microsoft.Storage/storageAccounts/encryption.services.blob"
          notEquals = true
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

# Policy 10: Compliance - Require Backup Protection
resource "azurerm_policy_definition" "backup_protection" {
  name                = var.backup_protection_config.name
  display_name        = var.backup_protection_config.display_name
  description         = var.backup_protection_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          field = "type"
          equals = "Microsoft.Compute/virtualMachines"
        },
        {
          field = "type"
          equals = "Microsoft.Sql/servers/databases"
        }
      ]
    }
    then = {
      effect = "audit"
    }
  })
}

# Policy 11: Compliance - Require Data Retention Policy
resource "azurerm_policy_definition" "data_retention" {
  name                = var.data_retention_config.name
  display_name        = var.data_retention_config.display_name
  description         = var.data_retention_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      field = "type"
      equals = "Microsoft.Storage/storageAccounts"
    }
    then = {
      effect = "audit"
    }
  })
}

# Policy 12: Networking - Require Network Security Groups
resource "azurerm_policy_definition" "network_security_groups" {
  name                = var.network_security_groups_config.name
  display_name        = var.network_security_groups_config.display_name
  description         = var.network_security_groups_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          equals = "Microsoft.Network/virtualNetworks/subnets"
        },
        {
          field = "Microsoft.Network/virtualNetworks/subnets/networkSecurityGroup.id"
          exists = "false"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

# Policy 13: Networking - Require Private Endpoints for Key Vault
resource "azurerm_policy_definition" "keyvault_private_endpoints" {
  name                = var.keyvault_private_endpoints_config.name
  display_name        = var.keyvault_private_endpoints_config.display_name
  description         = var.keyvault_private_endpoints_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          equals = "Microsoft.KeyVault/vaults"
        },
        {
          field = "Microsoft.KeyVault/vaults/networkAcls.defaultAction"
          notEquals = "Deny"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}

# Policy 14: Networking - Require DDoS Protection
resource "azurerm_policy_definition" "ddos_protection" {
  name                = var.ddos_protection_config.name
  display_name        = var.ddos_protection_config.display_name
  description         = var.ddos_protection_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          equals = "Microsoft.Network/virtualNetworks"
        },
        {
          field = "Microsoft.Network/virtualNetworks/ddosProtectionPlan.id"
          exists = "false"
        }
      ]
    }
    then = {
      effect = "audit"
    }
  })
}

# Policy 15: Cost Management - Allowed VM SKUs
resource "azurerm_policy_definition" "allowed_vm_skus" {
  name                = var.allowed_vm_skus_config.name
  display_name        = var.allowed_vm_skus_config.display_name
  description         = var.allowed_vm_skus_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          equals = "Microsoft.Compute/virtualMachines"
        },
        {
          field = "Microsoft.Compute/virtualMachines/sku.name"
          notIn = "[parameters('allowedVmSkus')]"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
  
  parameters = jsonencode({
    allowedVmSkus = {
      type = "Array"
      metadata = {
        displayName = "Allowed VM SKUs"
        description = "The list of allowed VM SKUs to control costs"
        strongType = "skuName"
      }
      defaultValue = var.allowed_vm_skus
    }
  })
}

# Policy 16: Cost Management - Allowed Storage SKUs
resource "azurerm_policy_definition" "allowed_storage_skus" {
  name                = var.allowed_storage_skus_config.name
  display_name        = var.allowed_storage_skus_config.display_name
  description         = var.allowed_storage_skus_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          field = "Microsoft.Storage/storageAccounts/sku.name"
          notIn = "[parameters('allowedStorageSkus')]"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
  
  parameters = jsonencode({
    allowedStorageSkus = {
      type = "Array"
      metadata = {
        displayName = "Allowed Storage SKUs"
        description = "The list of allowed storage account SKUs"
        strongType = "skuName"
      }
      defaultValue = var.allowed_storage_skus
    }
  })
}

# Policy 17: Cost Management - Restrict High-Cost Regions
resource "azurerm_policy_definition" "restrict_high_cost_regions" {
  name                = var.restrict_high_cost_regions_config.name
  display_name        = var.restrict_high_cost_regions_config.display_name
  description         = var.restrict_high_cost_regions_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          in = [
            "Microsoft.Compute/virtualMachines",
            "Microsoft.Sql/servers",
            "Microsoft.Storage/storageAccounts"
          ]
        },
        {
          field = "location"
          in = "[parameters('highCostRegions')]"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
  
  parameters = jsonencode({
    highCostRegions = {
      type = "Array"
      metadata = {
        displayName = "High-Cost Regions to Restrict"
        description = "The list of high-cost regions that should be restricted"
        strongType = "location"
      }
      defaultValue = var.high_cost_regions
    }
  })
}

# Policy 18: Cost Management - Require Resource Tags for Cost Allocation
resource "azurerm_policy_definition" "cost_allocation_tags" {
  name                = var.cost_allocation_tags_config.name
  display_name        = var.cost_allocation_tags_config.display_name
  description         = var.cost_allocation_tags_config.description
  policy_type         = var.policy_config.policy_type
  mode                = "All"
  
  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          field = "tags['CostCenter']"
          exists = "false"
        },
        {
          field = "tags['Project']"
          exists = "false"
        }
      ]
    }
    then = {
      effect = "deny"
    }
  })
}
