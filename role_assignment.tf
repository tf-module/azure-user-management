
resource "azurerm_role_assignment" "owner_by_user_group" {
  count                = length(data.azuread_user.user.*)
  scope                = element(azurerm_resource_group.user_resource_group.*.id, count.index)
  role_definition_name = "owner"
  principal_id         = element(data.azuread_user.user.*.id, count.index)
}

resource "azurerm_role_assignment" "role_by_shared_group" {
  scope                = azurerm_resource_group.shared_resource_group.id
  role_definition_name = "contributor"
  principal_id         = azuread_group.user_group.id
}
