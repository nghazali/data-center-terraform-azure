module "confluence" {
  source     = "./products/confluence"
  count      = local.install_confluence ? 1 : 0
  depends_on = [module.storage]

  environment_name = var.environment_name
  namespace        = local.namespace
  vpc              = module.vpc
  eks              = module.aks
  ingress          = module.ingress

  db_major_engine_version = var.confluence_db_major_engine_version
  db_configuration = {
    db_allocated_storage = var.confluence_db_allocated_storage
    db_instance_class    = var.confluence_db_instance_class
    db_iops              = var.confluence_db_iops
    db_name              = var.confluence_db_name
  }

  db_snapshot_id           = var.confluence_db_snapshot_id
  db_snapshot_build_number = var.confluence_db_snapshot_build_number
  db_master_username       = var.confluence_db_master_username
  db_master_password       = var.confluence_db_master_password

  replica_count             = var.confluence_replica_count
  installation_timeout      = var.confluence_installation_timeout
  version_tag               = var.confluence_version_tag
  enable_synchrony          = var.confluence_collaborative_editing_enabled
  termination_grace_period  = var.confluence_termination_grace_period

  confluence_configuration = {
    helm_version = var.confluence_helm_chart_version
    cpu          = var.confluence_cpu
    mem          = var.confluence_mem
    min_heap     = var.confluence_min_heap
    max_heap     = var.confluence_max_heap
    license      = var.confluence_license
  }

  synchrony_configuration = {
    cpu        = var.synchrony_cpu
    mem        = var.synchrony_mem
    min_heap   = var.synchrony_min_heap
    max_heap   = var.synchrony_max_heap
    stack_size = var.synchrony_stack_size
  }

  local_home_size  = var.confluence_local_home_size
  shared_home_size = var.confluence_shared_home_size

  nfs_requests_cpu    = var.confluence_nfs_requests_cpu
  nfs_requests_memory = var.confluence_nfs_requests_memory
  nfs_limits_cpu      = var.confluence_nfs_limits_cpu
  nfs_limits_memory   = var.confluence_nfs_limits_memory

  shared_home_snapshot_id = var.confluence_shared_home_snapshot_id

  # If local Helm charts path is provided, Terraform will then install using local charts and ignores remote registry
  local_confluence_chart_path = local.local_confluence_chart_path

  resource_group_name = azurerm_resource_group.vnet-rg.name
  region              = azurerm_resource_group.vnet-rg.location
}
