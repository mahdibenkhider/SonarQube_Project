
output "public_ip_address" {
  value = azurerm_public_ip.example.ip_address
}




output "lb_nat_rule_frontend_port_start" {
  value = azurerm_lb_nat_rule.example.frontend_port_start
}
output "lb_nat_rule_frontend_port_end" {
  value = azurerm_lb_nat_rule.example.frontend_port_end
}

output "lb_nat_rule_backend_port" {
  value = azurerm_lb_nat_rule.example.backend_port
}


# Define the local file resource to output the public IP address

resource "local_file" "example" {
  filename   = "inventory.txt"
  content = "${azurerm_public_ip.example.ip_address}:51"
  depends_on = [azurerm_public_ip.example]
}

# output "port_mapping" {
#   value = azurerm_lb_nat_rule.example
# }

output "lb_nat_rule_frontend_port_range" {
  value = "${azurerm_lb_nat_rule.example.frontend_port_start}-${azurerm_lb_nat_rule.example.frontend_port_end}"
}