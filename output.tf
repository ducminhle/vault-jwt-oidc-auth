output "auth_path" {
  value = vault_jwt_auth_backend.backend.path
}

output "oidc_discovery_url" {
  value = vault_jwt_auth_backend.backend.oidc_discovery_url
}

output "role_names" {
  value = vault_jwt_auth_backend_role.roles.*.role_name
}