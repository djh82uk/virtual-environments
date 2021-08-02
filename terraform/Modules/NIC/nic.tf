resource "azurerm_network_interface" "VM1" {
  name                = "${var.vm_nic_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resourcegroup}"

  ip_configuration {
    name                          = "${var.ip_name}"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "${var.addr_allocation}"
    public_ip_address_id          = "${var.public_ip}"
  }
}

