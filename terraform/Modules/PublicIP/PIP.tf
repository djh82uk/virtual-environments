resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-pip"
  resource_group_name = "${var.resourcegroup}"
  location            = "${var.location}"
  allocation_method   = "${var.allocation}"
}