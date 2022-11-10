
resource "azurerm_resource_group" "vnet-rg" {
  name     = local.resource-group-name
  location = var.region
}
