locals {
  namespace           = "atlassian"
  resource-group-name = "${var.environment_name}-${var.region}"
  vnet-prefix         = var.environment_name
  cluster_name        = format("atlas-%s-cluster", var.environment_name)
  azure_sku_vm        = "Standard_B4ms"

  username = "my-admin"
  password = "Password!1234abcd"
  product  = "confluence"

  install_confluence = true

  local_confluence_chart_path = var.local_helm_charts_path != "" && var.confluence_install_local_chart ? "${var.local_helm_charts_path}/confluence" : ""

}


