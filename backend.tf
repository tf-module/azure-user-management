terraform {
  backend "azurerm" {
    storage_account_name  = "tfstate6843"
    container_name        = "tfstate"
    key                   = "user-resource-group-terraform.tfstate"
  }
}