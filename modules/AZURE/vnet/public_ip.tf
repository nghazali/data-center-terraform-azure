
resource "azurerm_public_ip" "pip" {
  name                = "${var.vnet_prefix}-pip"
  location            = var.region
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  tags = {
    environment = var.vnet_prefix
  }
}