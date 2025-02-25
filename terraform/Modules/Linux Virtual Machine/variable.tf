variable "resourcegroup" {}
variable "location" {default = "west europe"}
variable "addr_allocation" {default = "dynamic"}
variable "vm_name" {}
variable "vm_size" {}
variable "vm_admin_user" {}
variable "vm_admin_pass" {}
variable "osdisk_caching" {}
variable "storage_account_type" {}
variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}
variable "image_version" {}
variable "disable_password_auth" {default = true}
variable  "network_interface_ids" {}
