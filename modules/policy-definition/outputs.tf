# Policy Definition IDs Outputs
output "allowed_locations_policy_id" {
  description = "The ID of the Allowed Locations policy definition"
  value       = azurerm_policy_definition.allowed_locations.id
}

output "allowed_resource_types_policy_id" {
  description = "The ID of the Allowed Resource Types policy definition"
  value       = azurerm_policy_definition.allowed_resource_types.id
}

output "naming_convention_policy_id" {
  description = "The ID of the Naming Convention policy definition"
  value       = azurerm_policy_definition.naming_convention.id
}

output "required_tags_policy_id" {
  description = "The ID of the Required Tags policy definition"
  value       = azurerm_policy_definition.required_tags.id
}

output "tag_inheritance_policy_id" {
  description = "The ID of the Tag Inheritance policy definition"
  value       = azurerm_policy_definition.tag_inheritance.id
}

# Policy Definition Names Outputs
output "allowed_locations_policy_name" {
  description = "The name of the Allowed Locations policy definition"
  value       = azurerm_policy_definition.allowed_locations.name
}

output "allowed_resource_types_policy_name" {
  description = "The name of the Allowed Resource Types policy definition"
  value       = azurerm_policy_definition.allowed_resource_types.name
}

output "naming_convention_policy_name" {
  description = "The name of the Naming Convention policy definition"
  value       = azurerm_policy_definition.naming_convention.name
}

output "required_tags_policy_name" {
  description = "The name of the Required Tags policy definition"
  value       = azurerm_policy_definition.required_tags.name
}

output "tag_inheritance_policy_name" {
  description = "The name of the Tag Inheritance policy definition"
  value       = azurerm_policy_definition.tag_inheritance.name
}
