output "vnet" {
  description = "VPC network information"
  value       = azurerm_virtual_network.vpc
}

output "subnets-rds" {
  description = "Subnets information for RDS"
  value       = {
    subnet    = local.rds-subnet
    subnet_id = azurerm_subnet.rds.id
  }
}

output "subnets-gateway" {
  description = "List of subnets for gateway"
  value       = local.rds-subnet
}

output "subnet_id" {
  value = azurerm_subnet.rds.id
}

output "vpc_id" {
  value = azurerm_virtual_network.vpc.id
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks-subnet.id
}