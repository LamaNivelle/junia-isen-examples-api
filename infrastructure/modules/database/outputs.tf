output "postgresql_host" {
  description = "FQDN for the PostgreSQL server"
  value = azurerm_postgresql_flexible_server.ccp_postgres_server.fqdn
}

output "postgresql_port" {
  description = "Port of the database created within the PostgreSQL server"
  value = 5432
}

output "postgresql_db_name" {
  description = "Name of the database created within the postreSQL server"
  value = azurerm_postgresql_flexible_server_database.ccp_database.name
}

output "postgresql_user" {
  description = "Login of the administrator for the database"
  value = azurerm_postgresql_flexible_server.ccp_postgres_server.administrator_login
}