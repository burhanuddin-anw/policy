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
      effect = "audit"
    }
  })
}


# Policy 6: Cost Management - Allowed VM SKUs
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

# Policy 7: Cost Management - Allowed Storage SKUs
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

# Policy 8: Cost Management - Restrict High-Cost Regions
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

# Policy 9: Cost Management - Require Resource Tags for Cost Allocation
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
