
resource "azurerm_role_assignment" "owner_by_user_group" {
  for_each             = data.azuread_user.users
  scope                = azurerm_resource_group.user_resource_group[each.key].id
  role_definition_name = "owner"
  principal_id         = each.value["id"]
  depends_on           = [azurerm_resource_group.user_resource_group]
}

resource "azurerm_role_assignment" "role_by_shared_group" {
  scope                = azurerm_resource_group.shared_resource_group.id
  role_definition_name = "contributor"
  principal_id         = azuread_group.user_group.id
}

data "azuread_user" "owners" {
  for_each            = toset(var.subscription_owner_emails)
  user_principal_name = each.value
}

resource "azurerm_role_assignment" "owner_of_subscription" {
  for_each             = data.azuread_user.owners
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "owner"
  principal_id         = each.value["id"]
}