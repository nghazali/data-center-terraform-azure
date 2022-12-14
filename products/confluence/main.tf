# Create the infrastructure for confluence Data Center.
#resource "aws_route53_record" "confluence" {
#  count = local.domain_supplied ? 1 : 0
#
#  zone_id = var.ingress.outputs.r53_zone
#  name    = local.product_domain_name
#  type    = "A"
#
#  alias {
#    evaluate_target_health = false
#    name                   = var.ingress.outputs.lb_hostname
#    zone_id                = var.ingress.outputs.lb_zone_id
#  }
#}

module "database" {
  source = "../../modules/AZURE/postgres"

  vnet_prefix          = var.environment_name
  resource_group_name  = var.resource_group_name
  region               = var.region
  subnet_id            = var.vpc.subnets-rds.subnet_id
  vpc_id               = var.vpc.vpc_id
  product              = local.product_name
  db_name              = var.db_configuration["db_name"]
  major_engine_version = var.db_major_engine_version
  db_master_username   = var.db_master_username
  db_master_password   = var.db_master_password
  allocated_storage    = var.db_configuration["db_allocated_storage"]
  instance_class       = var.db_configuration["db_instance_class"]

}

#module "nfs" {
#  source = "../../modules/AZURE/nfs"
#
#  namespace               = var.namespace
#  product                 = local.product_name
#  requests_cpu            = var.nfs_requests_cpu
#  requests_memory         = var.nfs_requests_memory
#  limits_cpu              = var.nfs_limits_cpu
#  limits_memory           = var.nfs_limits_memory
#  availability_zone       = var.eks.availability_zone
#  shared_home_snapshot_id = var.shared_home_snapshot_id
#  shared_home_size        = var.shared_home_size
#  cluster_service_ipv4    = local.nfs_cluster_service_ipv4
#}