
resource "azurerm_postgresql_flexible_server" "instance" {
  name                   = local.instance_name
  resource_group_name    = var.resource_group_name
  location               = var.region
  version                = var.major_engine_version
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.default.id
  administrator_login    = var.db_master_username
  administrator_password = var.db_master_password
  zone                   = local.zone
  storage_mb             = var.allocated_storage
  sku_name               = var.instance_class
  backup_retention_days  = 7

  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}



resource "azurerm_network_security_group" "rds" {
  name                = local.network_security_name
  location            = var.region
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = local.security_rule_name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_subnet_network_security_group_association" "rds-nsg-association" {
  depends_on = [azurerm_network_security_group.rds]
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.rds.id
}

resource "azurerm_private_dns_zone" "default" {
  name                = "${var.vnet_prefix}-pdz.postgres.database.azure.com"
  resource_group_name = var.resource_group_name

  depends_on = [azurerm_subnet_network_security_group_association.rds-nsg-association]
}

resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "${var.vnet_prefix}-pdzvnetlink.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = var.vpc_id
  resource_group_name   = var.resource_group_name
}

