terraform {
  backend "azurerm" {
    resource_group_name  = "#{resource_group_name}#"
    storage_account_name = "#{storage_account_name}#"
    container_name       = "#{container_name}#"
    key                  = "#{blob_name}#"
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "RG1" {
  name     = "Packer-Build-RG"
  location = "West Europe"
}

module "VNet"{
source = "../Modules/Virtual Network/"
vnet_name       = "Packer-Build-VNet"
resourcegroup   = "${azurerm_resource_group.RG1.name}"
addrspace       = ["10.0.0.0/16"]
location        = "${azurerm_resource_group.RG1.location}"
 }
  
module "Subnet"{
source = "../Modules/Subnet/"
vnet_name       = "${module.VNet.vnetname}"
resourcegroup   = "${azurerm_resource_group.RG1.name}"
subnet_name     = "packer-subnet"
addrprefixes    = ["10.0.2.0/24"]
}

module "NSG"{
source = "../Modules/NSG/"
nsg_name       = "Packer-NSG"
resourcegroup   = "${azurerm_resource_group.RG1.name}"
homeip    = "81.99.9.160"
}

module "PIP"{
source = "../Modules/PublicIP/"
prefix       = "Packer"
resourcegroup   = "${azurerm_resource_group.RG1.name}"
}

module "NIC"{
source = "../Modules/NIC/"
vm_nic_name           = "Packer-Build-NIC"  
resourcegroup   = "${azurerm_resource_group.RG1.name}"
subnet_id             = module.Subnet.subnetid
public_ip_address_id  = "${module.PIP.pip.id}"
}


  
module "VM"{
source = "../Modules/Linux Virtual Machine/"
resourcegroup         = "${azurerm_resource_group.RG1.name}"
location              = "${azurerm_resource_group.RG1.location}"
vm_name               = "Packer-Build-VM-001"  
vm_size               = "Standard_B2s" 
network_interface_ids = ["module.NIC.id,]
disable_password_auth = false
vm_admin_user         = "#{admin_user}#" 
vm_admin_pass         = "#{admin_pass}#" 
osdisk_caching        = "ReadWrite"
storage_account_type  = "Standard_LRS"
image_publisher       = "Canonical"
image_offer           = "UbuntuServer"
image_sku             = "18.04-LTS"
image_version         = "latest"

}


