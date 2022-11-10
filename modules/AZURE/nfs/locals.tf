locals {

  # The name of the NFS server.
  nfs_name = "${var.product}-nfs"

  # The name of the NFS storage class.
  storage_class = "gp2"
  azure_storage_class = "Standard_LRS"
}