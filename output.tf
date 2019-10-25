
output "users" {
  value = data.azuread_user.users
}

output "user_resource_groups" {
  value = azurerm_resource_group.user_resource_group
}

output "shared_group" {
  value = azurerm_resource_group.shared_resource_group
}
