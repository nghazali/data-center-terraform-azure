
resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.region
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  tags                = {
    Environment = var.cluster_name
  }

  default_node_pool {
    name                 = "systempool"
    vm_size              = var.instance_type
    node_count           = var.agent_count
    enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    os_disk_size_gb      = 30
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps"
    }
    tags = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps"
    }
  }
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
#  service_principal {
#    client_id     = var.aks_service_principal_app_id
#    client_secret = var.aks_service_principal_client_secret
#  }
  # Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

}
