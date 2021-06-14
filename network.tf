
# Create the network VNET
resource "azurerm_virtual_network" "devops-challenge-vnet" {
  name                = "devops-challenge-vnet"
  address_space       = [var.vnet_cidr]
  resource_group_name = azurerm_resource_group.devops-challenge-rg.name
  location            = azurerm_resource_group.devops-challenge-rg.location
}
# Create a subnet for VM
resource "azurerm_subnet" "webserver-subnet" {
  name                 = "webserver-subnet"
  address_prefixes     = [var.webserver_subnet_cidr]
  virtual_network_name = azurerm_virtual_network.devops-challenge-vnet.name
  resource_group_name  = azurerm_resource_group.devops-challenge-rg.name
}

resource "azurerm_network_security_group" "webserver-nsg" {
  name                = "webserver-nsg"
  location            = azurerm_resource_group.devops-challenge-rg.location
  resource_group_name = azurerm_resource_group.devops-challenge-rg.name
  security_rule {
    name                       = "Allow-HTTPS"
    description                = "Allow HTTPS"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-HTTP"
    description                = "Allow HTTP"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "webserver-nsg-association" {
  subnet_id                 = azurerm_subnet.webserver-subnet.id
  network_security_group_id = azurerm_network_security_group.webserver-nsg.id
}

# Get a Static Public IP
resource "azurerm_public_ip" "webserver-public-ip" {
  name                = "webserver-public-ip"
  location            = azurerm_resource_group.devops-challenge-rg.location
  resource_group_name = azurerm_resource_group.devops-challenge-rg.name
  allocation_method   = "Static"
}

# Create Network Card for the VM
resource "azurerm_network_interface" "webserver-nic" {
  name                = "webserver-nic"
  location            = azurerm_resource_group.devops-challenge-rg.location
  resource_group_name = azurerm_resource_group.devops-challenge-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.webserver-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webserver-public-ip.id
  }
}