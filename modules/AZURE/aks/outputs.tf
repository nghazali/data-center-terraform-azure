output "cluster_id" {
  value     = azurerm_kubernetes_cluster.k8s.id
#  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config
  sensitive = true
}

