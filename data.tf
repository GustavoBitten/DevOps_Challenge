data "azurerm_storage_account_sas" "sas_to_storage_webserver_logs" {
  connection_string = azurerm_storage_account.storage_webserver_logs.primary_connection_string
  https_only        = false
  signed_version    = "2017-07-29"

  resource_types {
    service   = false
    container = true
    object    = true
  }

  services {
    blob  = true
    table = true
    queue = false
    file  = false
  }

  start  = "2018-03-21T00:00:00Z"
  expiry = "2026-03-21T00:00:00Z"

  permissions {
    add     = true
    create  = true
    list    = true
    update  = true
    write   = true
    read    = false
    delete  = false
    process = false
  }
}

