
resource "azurerm_managed_disk" "shared_home" {
  name                 = "acctestmd"
  location             = var.region
  resource_group_name  = var.resource_group_name
  storage_account_type = local.azure_storage_class # e.g. "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = tonumber(regex("\\d+", var.shared_home_size)) # "1"

  tags = {
    Name = "${var.product}-nfs-shared-home"
  }
}

resource "kubernetes_persistent_volume" "nfs_shared_home" {
  metadata {
    name = "${local.nfs_name}-pv"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    capacity = {
      storage = var.shared_home_size
    }
    storage_class_name = local.storage_class
    persistent_volume_source {
      aws_elastic_block_store {
        volume_id = azurerm_managed_disk.shared_home.id
      }
    }
    claim_ref {
      name      = "${local.nfs_name}-pvc"
      namespace = var.namespace
    }
  }
}

resource "kubernetes_persistent_volume_claim" "nfs_shared_home" {
  metadata {
    name      = "${local.nfs_name}-pvc"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = var.shared_home_size
      }
    }
    storage_class_name = local.storage_class
    volume_name        = kubernetes_persistent_volume.nfs_shared_home.metadata.0.name
  }
}
