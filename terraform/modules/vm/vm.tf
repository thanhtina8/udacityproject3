resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"


  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                  = "${var.application_type}-${var.resource_type}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username        = "${var.admin_username}"
  admin_password        = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.test.id]
 
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key =  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIz7/mG5RQusBNJbn2AVKd8XxRaLrTCoUxi3lgIy8u7/XbbID77OG5hkiBLMRiaXW+i+6gPEE4sYkVOvgFV/RbeGiy765mEzP2ZqHsl4JZPFDqUhxjnLwObWHJYp3+W4uebEfjB3w5EJVep/v/DqGIq1Ik1DezaAKBFeZ+mhWSt1uXRyxQQJW43A3cp32z0nNGsJXykSh7eWaOt6NZ6bIOikIFDU7otTzjjPjFCGjLLaQk0qj3ZDQ8ElM2FrPZaB60VjHVmUv+WW6ZceKsrpDge7iNYJdWahoND9e5LOggKlcXQJzrX/nRayZsnC0qzP8fnXppOtrw5bStpFOOP9Koukkeyro8JgfvXOPGMtvOEyP5qmZVjScs9zVwKm5cxeAeH08sWDaDZUgObV4yudXm3yYAXXqrJidpKjlIQ6za9rTADXvuLcqU1XrCDlRzqKgHEDRDtvLCLHp7Bt+y0DfdJx+Nv2b2S7N4OZfVafibbtUQJKzI2u7E8B6/hkY7cPM= odl_user@SandboxHost-638666411326198052"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
