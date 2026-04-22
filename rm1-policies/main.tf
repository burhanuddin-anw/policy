terraform {
  required_version = ">= 1.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Get current subscription
data "azurerm_subscription" "current" {}


# Call the policy definitions module
module "policy_definitions" {
  source = "../modules/policy-definition"

  allowed_locations      = var.allowed_locations
  allowed_resource_types = var.allowed_resource_types
  required_tags          = var.required_tags
  naming_prefixes        = var.naming_prefixes
  allowed_vm_skus        = var.allowed_vm_skus
  allowed_storage_skus   = var.allowed_storage_skus
  high_cost_regions      = var.high_cost_regions
}

# Create the policy set definition (initiative)
resource "azurerm_policy_set_definition" "rm1_governance_initiative" {
  name         = "rm1-governance-initiative"
  display_name = "RM1 Governance Initiative"
  description  = "Comprehensive governance policies including location, resource types, naming conventions, and tagging requirements"
  policy_type  = "Custom"

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.allowed_locations_policy_id
    parameter_values = jsonencode({
      allowedLocations = {
        value = "[parameters('allowedLocations')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.naming_convention_policy_id
  }

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.allowed_resource_types_policy_id
    parameter_values = jsonencode({
      allowedResourceTypes = {
        value = "[parameters('allowedResourceTypes')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.required_tags_policy_id
    parameter_values = jsonencode({
      requiredTags = {
        value = "[parameters('requiredTags')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.tag_inheritance_policy_id
  }

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.allowed_vm_skus_policy_id
    parameter_values = jsonencode({
      allowedVmSkus = {
        value = "[parameters('allowedVmSkus')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.allowed_storage_skus_policy_id
    parameter_values = jsonencode({
      allowedStorageSkus = {
        value = "[parameters('allowedStorageSkus')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.restrict_high_cost_regions_policy_id
    parameter_values = jsonencode({
      highCostRegions = {
        value = "[parameters('highCostRegions')]"
      }
    })
  }

  policy_definition_reference {
    policy_definition_id = module.policy_definitions.cost_allocation_tags_policy_id
  }

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed locations"
        description = "The list of locations that resources can be deployed to"
      }
      value = var.allowed_locations
    }

    allowedResourceTypes = {
      type = "Array"
      metadata = {
        displayName = "Allowed resource types"
        description = "The list of resource types that can be deployed"
      }
      value = var.allowed_resource_types
    }

    requiredTags = {
      type = "Array"
      metadata = {
        displayName = "Required tags"
        description = "The list of required tags for resources"
      }
      value = var.required_tags
    }

    allowedVmSkus = {
      type = "Array"
      metadata = {
        displayName = "Allowed VM SKUs"
        description = "The list of allowed VM SKUs to control costs"
      }
      value = var.allowed_vm_skus
    }

    allowedStorageSkus = {
      type = "Array"
      metadata = {
        displayName = "Allowed Storage SKUs"
        description = "The list of allowed storage account SKUs"
      }
      value = var.allowed_storage_skus
    }

    highCostRegions = {
      type = "Array"
      metadata = {
        displayName = "High-Cost Regions to Restrict"
        description = "The list of high-cost regions that should be restricted"
      }
      value = var.high_cost_regions
    }
  })
}

# Assign the initiative to the subscription
resource "azurerm_subscription_policy_assignment" "rm1_governance_assignment" {
  name                 = "rm1-gov-assign"
  display_name         = "RM1 Governance Policy Assignment"
  description          = "Assign RM1 governance initiative to subscription"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_set_definition.rm1_governance_initiative.id
  location             = "uaenorth"

  identity {
    type = "SystemAssigned"
  }

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed locations"
        description = "The list of locations that resources can be deployed to"
      }
      value = var.allowed_locations
    }

    allowedResourceTypes = {
      type = "Array"
      metadata = {
        displayName = "Allowed resource types"
        description = "The list of resource types that can be deployed"
      }
      value = var.allowed_resource_types
    }

    requiredTags = {
      type = "Array"
      metadata = {
        displayName = "Required tags"
        description = "The list of required tags for resources"
      }
      value = var.required_tags
    }
  })
}
