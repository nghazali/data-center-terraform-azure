
output "rds_instance_name" {
  value = azurerm_postgresql_flexible_server.instance.name
}

output "rds_db_name" {
  value = azurerm_postgresql_flexible_server_database.db.name
}

output "rds_jdbc_connection" {
  value = "jdbc:postgresql://${local.instance_name}.postgres.database.azure.com:5432/${local.database_name}?sslmode=require"
}

output "rds_instance_id" {
  value = azurerm_postgresql_flexible_server.instance.id
}

output "rds_master_username" {
  value = azurerm_postgresql_flexible_server.instance.administrator_login
}

output "rds_master_password" {
  value     = azurerm_postgresql_flexible_server.instance.administrator_password
  sensitive = true
}

output "rds_endpoint" {
  value = azurerm_postgresql_flexible_server.instance.connection
}

output "rds_connection" {
  value = azurerm_postgresql_flexible_server_database.db..db_jdbc_connection
}
