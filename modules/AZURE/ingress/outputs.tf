output "outputs" {
  value = {
    domain          = var.ingress_domain
    lb_hostname     = data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].hostname
  }
}
