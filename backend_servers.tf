resource "azurerm_linux_virtual_machine" "backend" {
  count               = 4
  name                = "backend-server-${count.index + 1}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  size                = var.instance_type
  admin_username      = "adminuser"
  network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = {
    environment = "backend"
  }
}
