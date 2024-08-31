provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "rg-main"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-main"
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "public" {
  name                 = "subnet-public"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_cidr]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-main"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow_http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_https"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_ssh"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  count               = 6
  name                = "nic-${count.index + 1}"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
  }

  network_security_group_id = azurerm_network_security_group.nsg.id
}
