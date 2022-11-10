resource "azurerm_storage_account" "nfs-acc" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = local.account_tier
  account_replication_type = local.account_replication_type
}

resource "azurerm_storage_share" "nfs" {
  name                 = "shared-home"
  storage_account_name = azurerm_storage_account.nfs-acc.name
  quota                = var.maximum_size

  enabled_protocol = "NFS"
  acl {
    id = "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI"

    access_policy {
      permissions = "rwdl"
      #      start       = "2019-07-02T09:38:21.0000000Z"
      #      expiry      = "2019-07-02T10:38:21.0000000Z"
    }
  }
}