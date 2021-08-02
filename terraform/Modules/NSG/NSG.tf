resource "azurerm_network_security_group" "Packer" {
  name                = "${var.nsg_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resourcegroup}"


  security_rule {
    name                       = "ssh_home"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.homeip}"
    destination_address_prefix = "*"
    }

  }