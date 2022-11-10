output "vpc-detail" {
  description = "VPC network detail"

  value = {
    id = module.vpc.vnet.id
    public_subnet_cidr = module.vpc.vnet.subnet
  }
}

output "vpc" {
  description = "VPC network information"
  value = module.vpc.vnet
}

output "AKS" {
  description = "Azure Kubernetes information"
  value = {
    client_certificate = module.aks.cluster_id
    kube_config = module.aks.kube_config
  }
  sensitive = true
}

output "RDS" {
  description = "Database information"
  value       = {
    azurerm_postgresql_server       = module.rds.azurerm_postgresql_flexible_server
    postgresql_server_database_name = module.rds.postgresql_flexible_server_database_name
    rds_jdbc_connection             = module.rds.rds_jdbc_connection
  }
}

#output "AKS endpoint" {
#  value = module.aks.endpoint
#}