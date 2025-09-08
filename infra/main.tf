module "rg" {
  source      = "../module/azurerm_resource_group"
  rg_name     = "jaypee-rg"
  rg_location = "central india"
}

module "vnet" {
  depends_on               = [module.rg]
  source                   = "../module/azurerm_virtual_network"
  virtual_network_name     = "jaypee-vnet"
  virtual_network_location = "central india"
  resource_group_name      = "jaypee-rg"
  address_space            = ["10.0.0.0/24"]
}
module "subnet" {
  depends_on           = [module.vnet]
  source               = "../module/azurerm_subnet"
  subnet_name          = "jaypee-subnet"
  resource_group_name  = "jaypee-rg"
  virtual_network_name = "jaypee-vnet"
  address_prefixes     = ["10.0.0.0/28"]

}

module "keyvault" {
  depends_on          = [module.rg]
  source              = "../module/azurerm_keyvault"
  key_vault_name      = "jaypeekeyvault"
  location            = "centralindia"
  resource_group_name = "jaypee-rg"

}

module "keyvault_secret_username" {
  depends_on          = [module.keyvault]
  source              = "../module/azurerm_key_vault_secret"
  secret_name         = "vm-username"
  secret_value        = "jaypeeadmin"
  key_vault_name      = "jaypeekeyvault"
  resource_group_name = "jaypee-rg"
}

module "keyvault_secret_password" {
  depends_on          = [module.keyvault]
  source              = "../module/azurerm_key_vault_secret"
  secret_name         = "vm-password"
  secret_value        = "Jaypee@12345"
  key_vault_name      = "jaypeekeyvault"
  resource_group_name = "jaypee-rg"

}

module "jaypee_vm1" {
  source               = "../module/azurerm_virtual_machine"
  depends_on           = [module.subnet, module.keyvault_secret_username, module.keyvault_secret_password]
  resource_group_name  = "jaypee-rg"
  location             = "centralindia"
  vm_name              = "jaypee-vm1"
  vm_size              = "Standard_B1s"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "nic-jyapee-vm1"
  vnet_name            = "jaypee-vnet"
  frontend_subnet_name = "jaypee-subnet"
  key_vault_name       = "jaypeekeyvault"
  username_secret_name = "vm-username"
  password_secret_name = "vm-password"
}

module "jaypee_vm2" {
  source               = "../module/azurerm_virtual_machine"
  depends_on           = [module.subnet, module.keyvault_secret_username, module.keyvault_secret_password]
  resource_group_name  = "jaypee-rg"
  location             = "centralindia"
  vm_name              = "jaypee-vm2"
  vm_size              = "Standard_B1s"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "nic-jaypee-vm2"
  vnet_name            = "jaypee-vnet"
  frontend_subnet_name = "jaypee-subnet"
  key_vault_name       = "jaypeekeyvault"
  username_secret_name = "vm-username"
  password_secret_name = "vm-password"
}

module "pip" {
  source               = "../module/azurerm_public_ip"
  depends_on           = [module.rg]
  public_ip_name       = "jaypee-pip"
  resource_group_name  = "jaypee-rg"
  location             = "centralindia"
  allocation_method    = "Static"
}

module "bastion_subnet" {
  source               = "../module/azurerm_bastion_subnet"
  depends_on           = [module.vnet]
  rg_name              = "jaypee-rg"
  vnet_name            = "jaypee-vnet"

}

module "bastion" {
  source                         = "../module/azurerm_bastion"
  depends_on                     = [module.pip , module.vnet,module.bastion_subnet, module.rg]
  bastion_name                   = "jaypee-bastion"
  location                       = "centralindia"
  rg_name                        = "jaypee-rg"
  vnet_name                      = "jaypee-vnet"
  pip_name                       = "jaypee-pip"
}

