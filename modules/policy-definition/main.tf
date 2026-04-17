# Policy 1: Allowed Locations - UAE North only
resource "azurerm_policy_definition" "allowed_locations" {
  name                = var.allowed_locations_config.name
  display_name        = var.allowed_locations_config.display_name
  description         = var.allowed_locations_config.description
  policy_type         = var.policy_config.policy_type
  mode                = var.policy_config.mode
  
  policy_rule = jsonencode({
    if = {
      field = "location"
      notIn = "[parameters('allowedLocations')]"
    }
    then = {
      effect = "warning"
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
  mode                = var.policy_config.mode
  
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
  mode                = var.policy_config.mode
  
  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type"
          equals = "Microsoft.Resources/subscriptions/resourceGroups"
        },
        {
          anyOf = [
            {
              field = "name"
              notLike = var.naming_prefixes[0]
            },
            {
              field = "name"
              notLike = var.naming_prefixes[1]
            },
            {
              field = "name"
              notLike = var.naming_prefixes[2]
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
  mode                = var.policy_config.mode
  
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
  mode                = var.policy_config.mode
  
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
