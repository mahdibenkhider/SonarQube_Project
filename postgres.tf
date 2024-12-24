
resource "azurerm_subnet" "postgresql" {
  name                 = var.subnet_postgresql
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

}
resource "azurerm_private_dns_zone" "SonarQube_dns" {
  name                = var.private_dns_zone
  resource_group_name = data.azurerm_resource_group.example.name
  tags = {
    Environment = var.tags
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "SonarQube_network_link" {
  name                  = var.dns_zone_virtual_network_link
  private_dns_zone_name = azurerm_private_dns_zone.SonarQube_dns.name
  virtual_network_id    = azurerm_virtual_network.example.id
  resource_group_name   = data.azurerm_resource_group.example.name
  tags = {
    Environment = var.tags
  }
}

resource "azurerm_postgresql_flexible_server" "SonarQube_server" {
  name                   = var.postgresql_flexible_server
  resource_group_name    = data.azurerm_resource_group.example.name
  location               = data.azurerm_resource_group.example.location
  version                = "12"
  delegated_subnet_id    = azurerm_subnet.postgresql.id
  private_dns_zone_id    = azurerm_private_dns_zone.SonarQube_dns.id
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  #   la zone est comptible vaec une version "GP_Standard_D4s_v3" 
  zone = "2"

  storage_mb = 32768

  sku_name = "GP_Standard_D4s_v3"
  #   sku_name   = "B_Standard_B1ms"
  
  depends_on = [azurerm_private_dns_zone_virtual_network_link.SonarQube_network_link]
  tags = {
    Environment = var.tags
  }

}
