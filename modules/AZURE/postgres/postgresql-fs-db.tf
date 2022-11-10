resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.instance.id
  collation = "en_US.UTF8"
  charset   = "UTF8"
}