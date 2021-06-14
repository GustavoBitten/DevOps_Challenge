
resource "azurerm_linux_virtual_machine" "webserver" {
  name                  = "webserver"
  location              = azurerm_resource_group.devops-challenge-rg.location
  resource_group_name   = azurerm_resource_group.devops-challenge-rg.name
  network_interface_ids = [azurerm_network_interface.webserver-nic.id]
  size                  = var.webserver_size
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  os_disk {
    name                 = "webserver-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  computer_name  = "webserver"
  admin_username = var.webserver_admin_username
  admin_password = var.webserver_admin_password

  disable_password_authentication = false
}

resource "azurerm_virtual_machine_extension" "custom_script_webserver" {
  name                 = "setup_webserver"
  virtual_machine_id   = azurerm_linux_virtual_machine.webserver.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = local.custom_script_settings
}

resource "azurerm_virtual_machine_extension" "linux_diagnostic_webserver" {
  name                       = "send_logs_to_storage"
  virtual_machine_id         = azurerm_linux_virtual_machine.webserver.id
  publisher                  = "Microsoft.Azure.Diagnostics"
  type                       = "LinuxDiagnostic"
  type_handler_version       = "3.0"
  auto_upgrade_minor_version = "true"

  settings = local.linux_diagnostic_settings

  protected_settings = local.linux_diagnostic_protected_settings
}

resource "null_resource" "test_port_80" {
  triggers = {
    custom_script_webserver = azurerm_virtual_machine_extension.custom_script_webserver.id
  }
  provisioner "local-exec" {
    command = "echo 'if the test result is positive, the result will appear below.' & curl -Is ${azurerm_public_ip.webserver-public-ip.ip_address}:80"
  }
}