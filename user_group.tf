data "azuread_user" "users" {
  for_each            = toset(var.user_emails)
  user_principal_name = each.value
}

resource "azuread_group" "user_group" {
  name    = var.team_name
  members = values(data.azuread_user.users).*.object_id
}

resource "azurerm_resource_group" "user_resource_group" {
  for_each = data.azuread_user.users
  name     = replace(each.value["display_name"], "/(\\s+)/", "-")
  location = var.resource_location

  tags = {
    owner       = each.value["display_name"]
    owner_email = each.value["user_principal_name"]
  }
}

resource "azurerm_resource_group" "shared_resource_group" {
  name     = "Team-Sharing-Group"
  location = var.resource_location

  tags = {
    owner = "team"
  }
}