resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-host"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = "bastionIPconf"
    subnet_id            = data.azurerm_subnet.bastion_subnet_id.id
    public_ip_address_id = data.azurerm_public_ip.pip.id
  }
}
