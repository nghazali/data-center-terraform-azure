locals {
  resource-group-name = "${var.environment_name}-${var.region}"
  vnet-prefix         = var.environment_name

  cluster_name = format("atlas-%s-cluster", var.environment_name)

  vmsize = "Standard_B1s"
  username = "my-admin"
  password = "Password!1234abcd"

  product = "confie"

  namespace = "atlassian"
}


