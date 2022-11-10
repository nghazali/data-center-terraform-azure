
resource "azurerm_virtual_network" "vpc" {
  name                = var.vpc_name
  location            = var.region
  resource_group_name = var.resource_group_name
  address_space       = [var.vpc_cidr]

  tags = {
    environment = var.vpc_name
  }
}




resource "azurerm_network_interface" "nic" {
  name                 = "${var.vnet_prefix}-nic"
  location             = var.region
  resource_group_name  = var.resource_group_name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = var.vnet_prefix
    subnet_id                     = azurerm_subnet.mgmt.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}
