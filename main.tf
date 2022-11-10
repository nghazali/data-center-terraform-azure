
module "aks" {
  source = "./modules/AZURE/aks"
  depends_on = [module.vpc]

  resource_group_name = azurerm_resource_group.vnet-rg.name
  region              = azurerm_resource_group.vnet-rg.location
  cluster_name        = local.cluster_name
  agent_count         = 1
  instance_type       = local.azure_sku_vm
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.vpc.aks_subnet_id
}

module "vpc" {
  source = "./modules/AZURE/vnet"

  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = format("atlas-%s-vpc", var.environment_name)
  resource_group_name = azurerm_resource_group.vnet-rg.name
  region              = azurerm_resource_group.vnet-rg.location
  vnet_prefix         = var.environment_name
}

module "rds" {
  source = "./modules/AZURE/postgres"

  vnet_prefix          = var.environment_name
  resource_group_name  = azurerm_resource_group.vnet-rg.name
  region               = azurerm_resource_group.vnet-rg.location
  subnet_id            = module.vpc.subnets-rds.subnet_id
  vpc_id               = module.vpc.vpc_id
  product              = local.product
  db_name              = "confluence"
  major_engine_version = "13"
  db_master_username   = "postgres"
  db_master_password   = "Password!234"
  allocated_storage    = 32768
  instance_class       = "B_Standard_B1ms"
}

#module "nfs" {
#  source     = "./modules/AZURE/nfs"
#  depends_on = [kubernetes_namespace.products]
#
#  resource_group_name  = azurerm_resource_group.vnet-rg.name
#  region               = azurerm_resource_group.vnet-rg.location
#  namespace            = local.namespace
#  product              = local.product
#  requests_cpu         = "1"
#  requests_memory      = "500m"
#  availability_zone    = "1"
#  shared_home_size     = var.shared_home_size
#  cluster_service_ipv4 = "10.0.4.4"
#}

module "storage" {
  source     = "./modules/AZURE/storage"
  depends_on = [kubernetes_namespace.products]

  resource_group_name  = azurerm_resource_group.vnet-rg.name
  region               = azurerm_resource_group.vnet-rg.location
  namespace            = local.namespace
  product              = local.product
#  shared_home_size     = var.shared_home_size
}

variable "shared_home_size" {
  description = "The storage capacity to allocate to shared home"
  type        = string
  default     = "1Gi"
  validation {
    condition     = can(regex("^[0-9]+([gG]|Gi)$", var.shared_home_size))
    error_message = "Invalid shared home persistent volume size. Should be a number followed by 'Gi' or 'g'."
  }
}

resource "kubernetes_namespace" "products" {
  depends_on = [module.aks]
  metadata {
    name = "atlassian"
  }
}
