resource "azurerm_subnet" "gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = [local.gateway-subnet]
}

resource "azurerm_subnet" "mgmt" {
  name                 = "mgmt"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = [local.mgmt-subnet]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "onprem-nsg" {
  name                = "${var.vnet_prefix}-nsg"
  location            = var.region
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.vnet_prefix
  }
}

resource "azurerm_subnet_network_security_group_association" "mgmt-nsg-association" {
  subnet_id                 = azurerm_subnet.mgmt.id
  network_security_group_id = azurerm_network_security_group.onprem-nsg.id
}



resource "azurerm_subnet" "rds" {
  name                 = "rds-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = [local.rds-subnet]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}


resource "azurerm_subnet" "aks-subnet" {
  name                 = "aks-default-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = [local.aks-subnet]
}