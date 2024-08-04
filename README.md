# Terraform Azure Hub Virtual Network with Azure Firewall

Terraform module to deploy Azure Hub Virtual Network and with Azure Firewall including the required AzureFirewallSubnet

## Prerequisites
- Authentication to Azure, see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure

## Sample usage

```hcl
module "hub {
  source  = "bayupw/hub-vnet-azurefirewall/azurerm"
  version = "0.0.1"

  location           = "Australia East"
  rg_name            = "rg-bayu-hub-ae"
  vnet_name          = "bayu-hub-vnet-ae"
  vnet_address_space = ["10.100.0.0/23"]
  subnets = {
    AzureFirewallSubnet = {
      address_prefixes = ["10.100.0.0/26"]
    }
  }

  firewall_name        = "fw-hub-ae"
  firewall_sku_name    = "AZFW_VNet"
  firewall_sku_tier    = "Premium"
  firewall_dns_proxy   = true
  firewall_policy_name = "policy-azfw-ae"
}
```

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-azurerm-hub-vnet-azurefirewall/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-azurerm-hub-vnet-azurefirewall/tree/master/LICENSE) for full details.