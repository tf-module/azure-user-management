data "azuread_user" "user" {
  count               = length(var.user_emails)
  user_principal_name = element(var.user_emails, count.index)
}

resource "azuread_group" "user_group" {
  name    = var.team_name
  members = data.azuread_user.user.*.object_id
}

resource "azurerm_resource_group" "user_resource_group" {
  count    = length(data.azuread_user.user.*)
  name     = replace(element(data.azuread_user.user.*.display_name, count.index), "/(\\s+)/", "-")
  location = var.resource_location

  tags = {
    owner       = element(data.azuread_user.user.*.display_name, count.index)
    owner_email = element(data.azuread_user.user.*.user_principal_name, count.index)
  }
}

resource "azurerm_resource_group" "shared_resource_group" {
  name     = "Team-Sharing-Group"
  location = var.resource_location

  tags = {
    owner = "team"
  }
}

output "user_resource_group" {
  value = azurerm_resource_group.user_resource_group
}
