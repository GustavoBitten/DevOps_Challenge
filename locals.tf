locals {

  linux_diagnostic_protected_settings = jsonencode({
    "storageAccountName" : "${azurerm_storage_account.storage_webserver_logs.name}",
    "storageAccountSasToken" : "${data.azurerm_storage_account_sas.sas_to_storage_webserver_logs.sas}",
  })

  linux_diagnostic_settings = jsonencode({
    "StorageAccount" : "${azurerm_storage_account.storage_webserver_logs.name}",
    "ladCfg" : {
      "diagnosticMonitorConfiguration" : {
        "eventVolume" : "Medium",
        "metrics" : {
          "metricAggregation" : [
            {
              "scheduledTransferPeriod" : "PT1H"
            },
            {
              "scheduledTransferPeriod" : "PT1M"
            }
          ],
          "resourceId" : "${azurerm_linux_virtual_machine.webserver.id}"
        }
      },
      "sampleRateInSeconds" : 15
    },
    "fileLogs" : [
      {
        "file" : "/var/log/nginx/access.log",
        "table" : "webserverLogs"
      }
    ]
  })

  custom_script_settings = jsonencode({
    "script" : "${base64encode(templatefile("script/setup_webserver_after_deploy.sh", {}))}"
  })
}
