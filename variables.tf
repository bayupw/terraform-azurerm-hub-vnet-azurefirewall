variable "location" {
  description = "(Required) The location/region where the virtual network is created. Changing this forces new resources to be created."
  nullable    = false
  type        = string
  default     = "Australia East"
}

variable "rg_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the subnets. Changing this forces new resources to be created."
  nullable    = false
  default     = "rg-bayu-hub"
}

variable "vnet_name" {
  description = "(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."
  nullable    = false
  default     = "hub-vnet"
}

variable "common_tags" {
  description = "(Optional) A mapping of tags to assign to the virtual network."
  type        = map(string)
  default     = {}
}

variable "vnet_address_space" {
  type        = list(string)
  description = " (Required) The address space that is used the virtual network. You can supply more than one address space."
  nullable    = false
  default     = ["10.100.0.0/23"]

  validation {
    condition     = length(var.vnet_address_space) > 0
    error_message = "Please provide at least one cidr as address space."
  }
}

variable "virtual_network_dns_servers" {
  type = object({
    dns_servers = list(string)
  })
  default     = null
  description = "(Optional) List of IP addresses of DNS servers"
}

variable "virtual_network_flow_timeout_in_minutes" {
  type        = number
  default     = null
  description = "(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between `4` and `30`minutes."

  validation {
    condition     = var.virtual_network_flow_timeout_in_minutes == null ? true : (var.virtual_network_flow_timeout_in_minutes >= 4 && var.virtual_network_flow_timeout_in_minutes <= 30)
    error_message = "Possible values for `var.virtual_network_flow_timeout_in_minutes` are between `4` and `30`minutes."
  }
}

variable "subnets" {
  description = "Subnets to be created."
  type = map(object(
    {
      address_prefixes = list(string) # (Required) The address prefixes to use for the subnet.
      delegations = optional(list(
        object(
          {
            name = string # (Required) A name for this delegation.
            service_delegation = object({
              name    = string                 # (Required) The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.Orbital/orbitalGateways`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StoragePool/diskPools`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, `Microsoft.Web/serverFarms`, `NGINX.NGINXPLUS/nginxDeployments` and `PaloAltoNetworks.Cloudngfw/firewalls`.
              actions = optional(list(string)) # (Optional) A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.
            })
          }
        )
      ))
    }
  ))
  default = {
    AzureFirewallSubnet = {
      address_prefixes = ["10.100.0.0/26"]
    }
  }
}

variable "firewall_pip_name" {
  description = "Azure Firewall public IP name."
  type        = string
  default     = "pip-azfw-securehub-ae"
}

variable "firewall_pip_allocation_method" {
  description = "Azure Firewall public IP allocation method."
  type        = string
  default     = "Static"
}

variable "firewall_pip_sku" {
  description = "Azure Firewall public IP SKU."
  type        = string
  default     = "Standard"
}

variable "firewall_name" {
  description = "Azure Firewall name."
  type        = string
  default     = "fw-securehub-ae"
}

variable "firewall_sku_name" {
  description = "Azure Firewall SKU name."
  type        = string
  default     = "AZFW_VNet"
}

variable "firewall_sku_tier" {
  description = "Azure Firewall SKU tier"
  type        = string
  default     = "Premium"
}

variable "firewall_dns_proxy" {
  description = "Set to true to enable DNS Proxy on Azure Firewall."
  type        = bool
  default     = true
}

variable "firewall_policy_name" {
  description = "Azure Firewall policy name."
  type        = string
  default     = "fw-policy"
}

variable "firewall_policy_sku" {
  description = "Azure Firewall policy SKU name."
  type        = string
  default     = "Premium"
}

variable "firewall_threat_intel_mode" {
  description = "Azure Firewall Threat Intelligence Mode."
  type        = string
  default     = "Alert"
}