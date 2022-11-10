
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
    max_count            = var.max_cluster_capacity
    min_count            = var.min_cluster_capacity
    os_disk_size_gb      = var.instance_disk_size
#    vnet_subnet_id       = var.subnet_id
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps"
    }
    tags = var.resource_tags
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

  # Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

}
