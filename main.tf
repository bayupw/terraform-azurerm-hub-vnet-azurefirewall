resource "azurerm_resource_group" "this" {
  location = var.location
  name     = var.rg_name
}

resource "azurerm_virtual_network_dns_servers" "this" {
  count = var.virtual_network_dns_servers == null ? 0 : 1

  virtual_network_id = azurerm_virtual_network.this.id
  dns_servers        = var.virtual_network_dns_servers.dns_servers
}

resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.vnet_address_space

  tags = merge(
    { "Name" = var.vnet_name },
    var.common_tags,
  )
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  address_prefixes     = each.value.address_prefixes
  name                 = each.key
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name

  dynamic "delegation" {
    for_each = each.value.delegations == null ? [] : each.value.delegations

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  # Explicit dependency to avoid parallel issue during creation of `azurerm_subnet_route_table_association` and `azurerm_subnet_network_security_group_association`
  depends_on = [azurerm_virtual_network_dns_servers.this]
}