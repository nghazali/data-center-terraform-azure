locals {
  ingress_version   = "4.0.6"
  ingress_name      = "ingress-nginx"
  ingress_namespace = "ingress-nginx"
  domain_supplied   = var.ingress_domain != null ? true : false
  enable_https_ingress = var.enable_https_ingress

  ssh_tcp_setting = var.enable_ssh_tcp ? yamlencode({
    tcp = {
      7999 : "atlassian/bitbucket:ssh"
    }
  }) : yamlencode({})

}
