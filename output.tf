output "website_access" {
  value = "http://${azurerm_public_ip.webserver-public-ip.ip_address}"
}