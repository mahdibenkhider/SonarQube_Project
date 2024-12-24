terraform {
  required_version = ">=1.0"
  backend "azurerm" {
    resource_group_name  = "Perso_Mahdi"
    storage_account_name = "terraformmahdibackend"
    container_name       = "mahdi-terraform"
    key                  = "sonarqubeprod.terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.67.0"
    }

  }

}




provider "azurerm" {
  features {
    virtual_machine_scale_set {
      force_delete = false
      # Cette option indique que lorsqu'une mise à jour du VMSS est nécessaire, les instances seront mises à jour de manière séquentielle plutôt que simultanée. 
      # Cela permet de minimiser les interruptions de service pendant la mise à jour.
      roll_instances_when_required = true
      # Cette option indique que le VMSS doit être mis à l'échelle à zéro (aucune instance) avant d'être supprimé. 
      # Cela permet de s'assurer qu'il n'y a pas d'instances en cours d'exécution avant de supprimer le VMSS.
      scale_to_zero_before_deletion = true
    }
  }
}