##################################################################
#######   postgresql   ############################################
###################################################################
variable "subnet_postgresql" {
  description = "subnet_postgresql"
  type        = string
}

variable "private_dns_zone" {
  description = "private_dns_zone"
  type        = string
}
variable "dns_zone_virtual_network_link" {
  description = "dns_zone_virtual_network_link"
  type        = string
}

variable "postgresql_flexible_server" {
  description = "postgresql_flexible_server"
  type        = string
}
variable "administrator_login" {
  description = "administrator_login"
  type        = string
}

variable "administrator_password" {
  description = "Number of VM instances in the scale set"
  type        = string
}
##################################################################
#######  load_balancer   ##########################################
###################################################################
variable "load_balancer" {
  description = "load balancer"
  type        = string
}

variable "frontend_ip_configuration" {
  description = "frontend_ip_configuration"
  type        = string
}
variable "lb_backend_address_pool" {
  description = "lb_backend_address_pool"
  type        = string
}

variable "azurerm_lb_probe" {
  description = "Number of VM instances in the scale set"
  type        = string
}
variable "lb_nat_rule_unleash" {
  description = "Name of the VM scale set"
  type        = string
}

variable "lb_outbound_rule" {
  description = "lb_outbound_rule"
  type        = string
}
variable "load_balancing_rule" {
  description = "load_balancing_rule"
  type        = string
}
variable "lb_nat_rule" {
  description = "lb_nat_rule"
  type        = string
}
variable "lb_probe_https" {
  description = "lb_probe_https"
  type        = string
}
##################################################################
#######   network   ##############################################
###################################################################
variable "subnet" {
  description = "subnet"
  type        = string
}
variable "virtual_network" {
  description = "virtual_network"
  type        = string
}
variable "public_ip" {
  description = "public_ip"
  type        = string
}
variable "domain_name_label" {
  description = "domain_name_label"
  type        = string
}
variable "network_interface" {
  description = "network_interface"
  type        = string
}

variable "network_security_group" {
  description = "network_security_group"
  type        = string
}

variable "security_rule_sonarqube" {
  description = "security_rule_sonarqube"
  type        = string
}
variable "security_rule_https" {
  description = "security_rule_https"
  type        = string
}
variable "security_rule_ssh" {
  description = "security_rule_ssh"
  type        = string
}
variable "security_rule_http" {
  description = "security_rule_http"
  type        = string
}

##################################################################
##### Create a virtual machine scale set ##########################
####################################################################
variable "machine_scale_set" {
  description = "machine_scale_set"
  type        = string
}
variable "admin_username" {
  description = "admin_username"
  type        = string
}
variable "admin_password" {
  description = "admin_password"
  type        = string
}
variable "azurerm_monitor_autoscale_setting" {
  description = "azurerm_monitor_autoscale_setting"
  type        = string
}

variable "tags" {
  description = "tags"
  type        = string
}
