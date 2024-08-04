output "azurerm_resource_group" {
  description = "The created Resource Group as an object with all of it's attributes."
  value       = azurerm_resource_group.this
}

output "azurerm_virtual_wan" {
  value       = azurerm_virtual_network_dns_servers.this
}

output "azurerm_virtual_network" {
  description = "The created Azure Virtual Network as an object with all of it's attributes."
  value       = azurerm_virtual_network.this
}

output "azurerm_subnet" {
  description = "The created Azure Virtual Network as an object with all of it's attributes."
  value       = { for k, v in azurerm_subnet.this : k => v }
}

output "azurerm_firewall" {
  description = "The created Azure Firewall as an object with all of it's attributes."
  value       = azurerm_firewall.this
}

output "azurerm_firewall_policy" {
  description = "The created Azure Firewall Policy as an object with all of it's attributes."
  value       = azurerm_firewall_policy.this
}