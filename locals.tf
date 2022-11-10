locals {
  namespace           = "atlassian"
  resource-group-name = "${var.environment_name}-${var.region}"
  vnet-prefix         = var.environment_name
  cluster_name        = format("atlas-%s-cluster", var.environment_name)
  azure_vmsize        = "Standard_B1s"

  username = "my-admin"
  password = "Password!1234abcd"
  product  = "confluence"
}


