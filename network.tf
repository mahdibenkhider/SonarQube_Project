##################################################################
####### # Create a virtual network   ##############################
###################################################################
resource "azurerm_virtual_network" "sonar_Vnet" {
  name                = var.virtual_network
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
}
##################################################################
####### #    Create a subnet    ###################################
####################################################################
resource "azurerm_subnet" "_sonarsubnet" {
  name                 = var.subnet
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

##################################################################
####### Create a public IP address ###############################
##################################################################

resource "azurerm_public_ip" "example" {
  name                = var.public_ip
  resource_group_name = data.azurerm_resource_group.example.name
  location            = data.azurerm_resource_group.example.location
  domain_name_label   = var.domain_name_label
  allocation_method   = "Static"   # Utilisez Static pour la référence SKU Standard
  sku                 = "Standard" # Référence SKU Standard pour l'adresse IP publique
}
# #################################################################
##### # Create an Azure Network Interface (NIC) ####################
####################################################################

resource "azurerm_network_interface" "example" {
  name                = var.network_interface
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  ip_configuration {
    name                          = "example-ip-config"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Environment = var.tags
  }
}

resource "azurerm_network_security_group" "sonar-NSG" {
  name                = var.network_security_group
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
}
resource "azurerm_network_security_rule" "sonarqube" {
  name                        = var.security_rule_sonarqube
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "9000"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.example.name
  resource_group_name         = data.azurerm_resource_group.example.name
}
resource "azurerm_network_security_rule" "http" {
  name                        = var.security_rule_http
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.example.name
  resource_group_name         = data.azurerm_resource_group.example.name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = var.security_rule_ssh 
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.example.name
  resource_group_name         = data.azurerm_resource_group.example.name
}

resource "azurerm_network_security_rule" "https" {
  name                        = var.security_rule_https
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.example.name
  resource_group_name         = data.azurerm_resource_group.example.name
}



resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}
