output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_name" {
  description = "Subnet name"
  value       = azurerm_subnet.subnet.name
}

output "subnet_id" {
  description = "Subnet ID"
  value       = azurerm_subnet.subnet.id
}

output "app_gateway_subnet_id" {
  description = "Subnet ID for gateway"
  value = azurerm_subnet.app_gateway_subnet.id
}

output "app_service_subnet_id" {
  description = "Subnet ID for app service"
  value = azurerm_subnet.app_service_subnet.id
}