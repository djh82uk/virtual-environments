resource "azurerm_linux_virtual_machine" "VM1" {
  name                = "${var.vm_name}"
  resource_group_name = "${var.resourcegroup}"
  location            = "${var.location}"
  size                = "${var.vm_size}"
  disable_password_authentication = "${var.disable_password_auth}"
  admin_username      = "${var.vm_admin_user}"
  admin_password      = "${var.vm_admin_pass}"    
  network_interface_ids = [
    "${var.network_interface_ids}"
  ]


  os_disk {
    caching              = "${var.osdisk_caching}"
    storage_account_type = "${var.storage_account_type}"
  }

  source_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }
}
