# Configure the Microsoft Azure Active Directory Provider
provider "azuread" {
  version = "~> 0.3"
}

provider "azurerm" {
  version = "=1.34.0"
}

data "azurerm_subscription" "primary" {}

