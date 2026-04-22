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

# Security Policies Outputs
output "storage_https_only_policy_id" {
  description = "The ID of the Storage HTTPS Only policy definition"
  value       = azurerm_policy_definition.storage_https_only.id
}

output "storage_private_endpoints_policy_id" {
  description = "The ID of the Storage Private Endpoints policy definition"
  value       = azurerm_policy_definition.storage_private_endpoints.id
}

output "diagnostic_settings_policy_id" {
  description = "The ID of the Diagnostic Settings policy definition"
  value       = azurerm_policy_definition.diagnostic_settings.id
}

# Compliance & Regulatory Policies Outputs
output "data_encryption_policy_id" {
  description = "The ID of the Data Encryption policy definition"
  value       = azurerm_policy_definition.data_encryption.id
}

output "backup_protection_policy_id" {
  description = "The ID of the Backup Protection policy definition"
  value       = azurerm_policy_definition.backup_protection.id
}

output "data_retention_policy_id" {
  description = "The ID of the Data Retention policy definition"
  value       = azurerm_policy_definition.data_retention.id
}

# Networking Policies Outputs
output "network_security_groups_policy_id" {
  description = "The ID of the Network Security Groups policy definition"
  value       = azurerm_policy_definition.network_security_groups.id
}

output "keyvault_private_endpoints_policy_id" {
  description = "The ID of the Key Vault Private Endpoints policy definition"
  value       = azurerm_policy_definition.keyvault_private_endpoints.id
}

output "ddos_protection_policy_id" {
  description = "The ID of DDoS Protection policy definition"
  value       = azurerm_policy_definition.ddos_protection.id
}

# Cost Management Policies Outputs
output "allowed_vm_skus_policy_id" {
  description = "The ID of Allowed VM SKUs policy definition"
  value       = azurerm_policy_definition.allowed_vm_skus.id
}

output "allowed_storage_skus_policy_id" {
  description = "The ID of Allowed Storage SKUs policy definition"
  value       = azurerm_policy_definition.allowed_storage_skus.id
}

output "restrict_high_cost_regions_policy_id" {
  description = "The ID of Restrict High-Cost Regions policy definition"
  value       = azurerm_policy_definition.restrict_high_cost_regions.id
}

output "cost_allocation_tags_policy_id" {
  description = "The ID of Cost Allocation Tags policy definition"
  value       = azurerm_policy_definition.cost_allocation_tags.id
}
