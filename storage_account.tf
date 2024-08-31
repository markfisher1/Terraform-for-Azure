resource "azurerm_storage_account" "storage" {
  name                     = var.s3_bucket_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "storage"
  }
}
