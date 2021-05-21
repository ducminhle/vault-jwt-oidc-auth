provider "vault" {
  address               = var.vault_address
  add_address_to_env    = var.add_address_to_env
  token                 = var.vault_token
  token_name            = var.token_name
  ca_cert_file          = var.ca_cert_file
  ca_cert_dir           = var.ca_cert_dir
  skip_tls_verify       = var.skip_tls_verify
  max_lease_ttl_seconds = var.max_lease_ttl_seconds
  max_retries           = var.max_retries
  namespace             = var.namespace

  dynamic "auth_login" {
    for_each = var.auth_login
    content {
      path       = lookup(auth_login.value, "path", null)
      namespace  = lookup(auth_login.value, "namespace", null)
      parameters = lookup(auth_login.value, "parameters", null)
    }
  }

  dynamic "client_auth" {
    for_each = var.auth_login
    content {
      cert_file = lookup(auth_login.value, "cert_file", null)
      key_file  = lookup(auth_login.value, "key_file", null)
    }
  }
}
