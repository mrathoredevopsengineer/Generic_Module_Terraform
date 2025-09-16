resource "azurerm_lb" "jaypee-lb" {
  name                = "jaypee-lb"
  location            = "centralindia"
  resource_group_name = "jaypee-rg"

  frontend_ip_configuration {
    name                 = "FrontendPublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.jaypee-lb.id
  name            = "lb_BackEndAddressPool"
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.jaypee-lb.id
  name            = "lb_probe"
  port            = 80
}

# IP and Port based routing.
resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.jaypee-lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "FrontendPublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool.id]
  probe_id                       = azurerm_lb_probe.probe.id
}






