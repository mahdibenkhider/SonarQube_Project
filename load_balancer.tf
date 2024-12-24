##################################################################
######## Create a resource group   #################################
####################################################################
data "azurerm_resource_group" "example" {
  name = "Perso_Mahdi"

}

##################################################################
####### Create a load balancer ###################################
##################################################################
resource "azurerm_lb" "vmss" {
  name                = var.load_balancer
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration
    public_ip_address_id = azurerm_public_ip.example.id
  }
}
##################################################################
###########     Create a backend pool ############################
##################################################################

resource "azurerm_lb_backend_address_pool" "bpepool" {
  #  resource_group_name = data.azurerm_resource_group.vmss.name
  loadbalancer_id = azurerm_lb.vmss.id
  name            = var.lb_backend_address_pool
}
##################################################################
###########     "azurerm_lb_probe"  ############################
##################################################################
resource "azurerm_lb_probe" "vmss" {
  #  resource_group_name = data.azurerm_resource_group.vmss.name
  loadbalancer_id = azurerm_lb.vmss.id
  name            = var.azurerm_lb_probe
  port            = 80

}
##################################################################
###### # Create a health probe https  ##################################
####################################################################

resource "azurerm_lb_probe" "example" {
  name             = var.lb_probe_https
  protocol         = "Tcp"
  port             = 443
  number_of_probes = 2
  loadbalancer_id  = azurerm_lb.vmss.id

}
##################################################################
###### # Create a load balancing rule ##############################
####################################################################
resource "azurerm_lb_rule" "lbnatrule" {
  
  loadbalancer_id                = azurerm_lb.vmss.id
  name                           = var.load_balancing_rule
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = var.frontend_ip_configuration
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bpepool.id]
  probe_id                       = azurerm_lb_probe.vmss.id
  disable_outbound_snat          = true
  # enable_outbound_snat = true  # Activer la SNAT

}
##################################################################
###### Create inbound NAT rules ####################################
####################################################################

resource "azurerm_lb_nat_rule" "example" {

  name                           = var.lb_nat_rule
  resource_group_name            = data.azurerm_resource_group.example.name
  loadbalancer_id                = azurerm_lb.vmss.id
  protocol                       = var.lb_nat_rule
  frontend_port_start            =  51 
  frontend_port_end              =  52 
  backend_port                   = 22
  frontend_ip_configuration_name = var.frontend_ip_configuration
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bpepool.id
  depends_on                     = [azurerm_lb_backend_address_pool.bpepool]

}
##################################################################
###### Create inbound NAT rules pour sonarqube #####################
##################################################################

resource "azurerm_lb_nat_rule" "sonarqube" {

  name                           = var.lb_nat_rule_unleash
  resource_group_name            = data.azurerm_resource_group.example.name
  loadbalancer_id                = azurerm_lb.vmss.id
  protocol                       = "Tcp"
  frontend_port_start            = 9000
  frontend_port_end              = 9150
  backend_port                   = 9000
  frontend_ip_configuration_name = var.frontend_ip_configuration
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bpepool.id
  depends_on                     = [azurerm_lb_backend_address_pool.bpepool]

}

# #################################################################
###### # Create an outbound rule  ####################################
####################################################################

resource "azurerm_lb_outbound_rule" "example" {
  name                    = var.lb_outbound_rule
  loadbalancer_id         = azurerm_lb.vmss.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bpepool.id



  frontend_ip_configuration {
    name = var.frontend_ip_configuration
  }
}

