output "vpc-detail" {
  description = "VPC network detail"

  value = {
    id                 = module.vpc.vnet.id
    public_subnet_cidr = module.vpc.vnet.subnet
  }
}

output "vpc" {
  description = "VPC network information"
  value       = module.vpc.vnet
}

output "AKS" {
  description = "Azure Kubernetes information"
  value = {
    client_certificate = module.aks.cluster_id
    kube_config        = module.aks.kube_config
  }
  sensitive = true
}

output "RDS" {
  description = "Database information"
  value = {
    instance_name       = module.rds.rds_instance_name
    database_name       = module.rds.rds_db_name
    rds_jdbc_connection = module.rds.rds_jdbc_connection
    endpoint            = module.rds.rds_endpoint
#    rds_connection      = module.rds.rds_connection
  }
}

output "nfs-claim" {
  value = module.storage.nfs_claim_name
}

output nginx {
  value = module.ingress.outputs
}
#output "confluence" {
#  description = "Confluence information"
#  value = {
#    confluence_url = local.install_confluence && length(module.confluence) == 1 ? module.confluence[0].product_domain_name : null
#    synchrony_url  = var.confluence_collaborative_editing_enabled && length(module.confluence) == 1 ? module.confluence[0].synchrony_url : null
#  }
#}