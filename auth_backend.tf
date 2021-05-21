resource "vault_jwt_auth_backend" "backend" {
  description            = var.description
  path                   = var.path
  type                   = var.type
  oidc_discovery_url     = var.oidc_discovery_url
  oidc_discovery_ca_pem  = var.oidc_discovery_ca_pem
  oidc_client_id         = var.oidc_client_id
  oidc_client_secret     = var.oidc_client_secret
  jwks_url               = var.jwks_url
  jwks_ca_pem            = var.jwks_ca_pem
  jwt_validation_pubkeys = var.jwt_validation_pubkeys
  jwt_supported_algs     = var.jwt_supported_algs
  bound_issuer           = var.bound_issuer
  default_role           = var.default_role

  dynamic "tune" {
    for_each = var.tune
    content {
      default_lease_ttl            = lookup(tune.value, "default_lease_ttl", null)
      max_lease_ttl                = lookup(tune.value, "max_lease_ttl", null)
      audit_non_hmac_response_keys = lookup(tune.value, "audit_non_hmac_response_keys", null)
      audit_non_hmac_request_keys  = lookup(tune.value, "audit_non_hmac_request_keys", null)
      listing_visibility           = lookup(tune.value, "listing_visibility", null)
      passthrough_request_headers  = lookup(tune.value, "passthrough_request_headers", null)
      allowed_response_headers     = lookup(tune.value, "allowed_response_headers", null)
      token_type                   = lookup(tune.value, "token_type", null)
    }
  }
}
