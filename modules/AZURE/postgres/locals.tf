locals {
  zone                  = "1"
  backup_retention_days = 7
  instance_name         = "${var.vnet_prefix}-${var.product}-server"
  network_security_name = "${var.vnet_prefix}-nsg"
  security_rule_name    = "${var.vnet_prefix}-rds"
  database_name         = var.product
}