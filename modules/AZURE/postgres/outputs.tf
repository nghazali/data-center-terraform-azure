
output "azurerm_postgresql_flexible_server" {
  value = azurerm_postgresql_flexible_server.instance.name
}

output "postgresql_flexible_server_database_name" {
  value = azurerm_postgresql_flexible_server_database.db.name
}

output "rds_jdbc_connection" {
  value = "jdbc:postgresql://${local.instance_name}.postgres.database.azure.com:5432/${local.database_name}?sslmode=require"
}