resource "azurerm_resource_group" "resourceGroup" {
  name     = "test-rg1"
  location = "South Central US"
}

resource "azurerm_storage_account" "storageAccount" {
  name                     = "storageacntswadeploy"
  resource_group_name      = azurerm_resource_group.resourceGroup.name
  location                 = azurerm_resource_group.resourceGroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account_static_website" "storageAccountStaticWebsite" {
  storage_account_id = azurerm_storage_account.storageAccount.id
  index_document     = "index.html"
  error_404_document = "error.html"
}

resource "azurerm_storage_blob" "storageAccountBlob1" {
  depends_on             = [azurerm_storage_account_static_website.storageAccountStaticWebsite]
  name                   = "index.html"
  type                   = "Block"
  storage_account_name   = azurerm_storage_account.storageAccount.name
  storage_container_name = "$web"
  source                 = "${path.module}/static/index.html"
  content_md5            = filemd5("${path.module}/static/index.html")
  content_type           = "text/html"
}

resource "azurerm_storage_blob" "storageAccountBlob2" {
  depends_on             = [azurerm_storage_account_static_website.storageAccountStaticWebsite]
  name                   = "error.html"
  type                   = "Block"
  storage_account_name   = azurerm_storage_account.storageAccount.name
  storage_container_name = "$web"
  source                 = "${path.module}/static/error.html"
  content_md5            = filemd5("${path.module}/static/error.html")
  content_type           = "text/html"
}
