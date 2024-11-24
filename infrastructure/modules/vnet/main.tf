# Define a virtual network (VNet) with a specified address space
resource "azurerm_virtual_network" "vnet" {
  name                = "ccp-vnet-${var.random_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space 
}

# Define a subnet for the Application Gateway
resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "ccp-appGatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]  
}

# Define a subnet for App Service with delegation to Microsoft.Web/serverFarms
resource "azurerm_subnet" "app_service_subnet" {
  name                 = "ccp-appServiceSubnet-${var.random_suffix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]  
  service_endpoints    = ["Microsoft.Web"]  

  delegation {
    name = "appServiceDelegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

# Define a subnet for PostgreSQL Flexible Server with service endpoints and delegation
resource "azurerm_subnet" "subnet" {
  name                 = "ccp-subnet-${var.random_suffix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  # Delegate the subnet to PostgreSQL Flexible Servers
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}