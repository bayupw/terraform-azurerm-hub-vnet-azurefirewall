resource "azurerm_public_ip" "this" {
  name                = var.firewall_pip_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = var.firewall_pip_allocation_method
  sku                 = var.firewall_pip_sku
}

resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = var.firewall_sku_name
  sku_tier            = var.firewall_sku_tier
  # dns_servers         = each.value.dns_servers
  firewall_policy_id  = azurerm_firewall_policy.this.id
  # private_ip_ranges   = each.value.private_ip_ranges
  threat_intel_mode = var.firewall_threat_intel_mode
  #zones             = each.value.zones

  ip_configuration {
    name                 = "${var.firewall_name}-configuration"
    public_ip_address_id = azurerm_public_ip.this.id
    subnet_id            = azurerm_subnet.this["AzureFirewallSubnet"].id
  }
}

resource "azurerm_firewall_policy" "this" {
  name                     = var.firewall_policy_name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  sku                      = var.firewall_policy_sku
  threat_intelligence_mode = var.firewall_threat_intel_mode

  # Enabling DNS Proxy on Azure Firewall is required for FQDN-based Network Rules
  dns {
    proxy_enabled = var.firewall_dns_proxy
  }

}