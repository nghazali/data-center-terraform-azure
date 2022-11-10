
output "nfs_claim_name" {
  value = kubernetes_persistent_volume_claim.nfs_shared_home.metadata[0].name
}