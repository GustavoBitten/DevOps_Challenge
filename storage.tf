resource "random_integer" "unique_storage_webserver_logs" {
  min = 1000
  max = 9999
}

resource "azurerm_storage_account" "storage_webserver_logs" {
  name                     = "webserverlogs${random_integer.unique_storage_webserver_logs.result}"
  location                 = azurerm_resource_group.devops-challenge-rg.location
  resource_group_name      = azurerm_resource_group.devops-challenge-rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

}