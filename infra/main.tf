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

module "jaypee_vm1" {
  source               = "../module/azurerm_virtual_machine"
  depends_on           = [module.subnet ] 
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
  key_vault_name       = "jaypee-kv"   # Key Vault should be created before with username and password secrets
  username_secret_name = "vm-username" # Key Vault different RG me bna do 
  password_secret_name = "vm-password"
  nsg_name             = "jaypee-nsg1"
}

module "jaypee_vm2" {
  source               = "../module/azurerm_virtual_machine"
  depends_on           = [module.subnet ]
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
  key_vault_name       = "jaypee-kv"
  username_secret_name = "vm-username"
  password_secret_name = "vm-password"
  nsg_name             = "jaypee-nsg2"
}

module "pip" {
  source               = "../module/azurerm_public_ip"
  depends_on           = [module.rg]
  public_ip_name       = "jaypee-pip"
  resource_group_name  = "jaypee-rg"
  location             = "centralindia"
  allocation_method    = "Static"
}

# module "bastion_subnet" {
#   source               = "../module/azurerm_bastion_subnet"
#   depends_on           = [module.vnet]
#   rg_name              = "jaypee-rg"
#   vnet_name            = "jaypee-vnet"

# }

# module "bastion" {
#   source                         = "../module/azurerm_bastion"
#   depends_on                     = [module.pip , module.vnet,module.bastion_subnet, module.rg]
#   bastion_name                   = "jaypee-bastion"
#   location                       = "centralindia"
#   rg_name                        = "jaypee-rg"
#   vnet_name                      = "jaypee-vnet"
#   pip_name                       = "jaypee-pip"
# }

# module "sql_server" {
#   source                      = "../module/azurerm_sql_server"
#   depends_on                  = [module.rg]
#   sql_server_name             = "jaypeesqlserver"
#   resource_group_name         = "jaypee-rg"
#   location                    = "centralindia"
#   administrator_login         = "jaypeeadmin"
#   administrator_login_password = "Jaypee@12345"
# }

# module "sql_database" {
#   source               = "../module/azurerm_sql_database"
#   depends_on           = [module.sql_server]
#   resource_group_name  = "jaypee-rg"
#   sql_database_name    = "jaypeesqldb"
#   sql_server_name      = "jaypeesqlserver"
# }

# module "lb" {
#   source               = "../module/azurerm_loadbalancer"
#   depends_on           = [module.pip, module.rg]
#   public_ip_name      = "jaypee-pip"
#   rg_name             = "jaypee-rg"
# }

# module "nic_lb_association_vm1" {
#   source               = "../module/azurerm_nic_lb_association"
#   depends_on           = [module.jaypee_vm1, module.lb]
#   nic_name             = "nic-jyapee-vm1"
#   rg_name              = "jaypee-rg"
#   lb_name             = "jaypee-lb"
#   lb_BackEndAddressPool_name = "lb_BackEndAddressPool"
# }

# module "nic_lb_association_vm2" {
#   source               = "../module/azurerm_nic_lb_association"
#   depends_on           = [module.jaypee_vm2, module.lb]
#   nic_name             = "nic-jaypee-vm2"
#   rg_name              = "jaypee-rg"
#   lb_name             = "jaypee-lb"
#   lb_BackEndAddressPool_name = "lb_BackEndAddressPool"
# }