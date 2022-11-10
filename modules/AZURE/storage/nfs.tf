#resource "azurerm_storage_account" "nfs-acc" {
#  name                     = local.storage_account_name
#  resource_group_name      = var.resource_group_name
#  location                 = var.region
#  account_tier             = local.account_tier
#  account_replication_type = local.account_replication_type
#}
#
#resource "azurerm_storage_share" "nfs" {
#  name                 = "sharedhome"
#  storage_account_name = azurerm_storage_account.nfs-acc.name
#  quota                = 100
#
#  enabled_protocol = "NFS"
#  acl {
#    id = random_uuid.uuid.result
#
#    access_policy {
#      permissions = "rwdl"
#            start       = "2022-07-02T09:38:21.0000000Z"
#            expiry      = "2023-07-02T10:38:21.0000000Z"
#    }
#  }
#}
#
#resource "random_uuid" "uuid" {
#}
