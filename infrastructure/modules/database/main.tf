resource "azurerm_postgresql_flexible_server" "postgres-server" {
  name                = "ccp-postgres-server"
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "16"
  delegated_subnet_id = var.subnet_id
  private_dns_zone_id = azurerm_private_dns_zone.ccp_dns_zone.id
  administrator_login = "ccpadmin"
  administrator_password = "admin"
  sku_name            = "GP_Standard_D4s_v3"
  storage_mb          = 32768
  public_network_access_enabled = false
  
  depends_on = [azurerm_private_dns_zone_virtual_network_link.ccp_dns_zone_link]

}

resource "azurerm_postgresql_flexible_server_firewall_rule" "firewall" {
  name                        = "ccp-fw"
  server_id                   = azurerm_postgresql_flexible_server.postgres-server.id
  start_ip_address            = "0.0.0.0"
  end_ip_address              = "255.255.255.255"
}

resource "azurerm_private_dns_zone" "ccp_dns_zone" {
  name                = "cpp.postgres.database.azure.com"
  resource_group_name = var.resource_group_name 
}

resource "azurerm_private_dns_zone_virtual_network_link" "ccp_dns_zone_link" {
  name                  = "ccp_dns_zone_link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.ccp_dns_zone.name
  virtual_network_id    = var.vnet_id
}