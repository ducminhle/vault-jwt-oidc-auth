resource "vault_jwt_auth_backend_role" "roles" {
  count     = length(var.roles)
  role_name = lookup(element(var.roles, count.index), "role_name", null)
  role_type = lookup(element(var.roles, count.index), "role_type", null)

  bound_audiences = [vault_jwt_auth_backend.backend.oidc_client_id]

  user_claim     = lookup(element(var.roles, count.index), "user_claim", null)
  bound_subject  = lookup(element(var.roles, count.index), "bound_subject", null)
  bound_claims   = lookup(element(var.roles, count.index), "bound_claims", null)
  claim_mappings = lookup(element(var.roles, count.index), "claim_mappings", null)

  oidc_scopes  = lookup(element(var.roles, count.index), "oidc_scopes", null)
  groups_claim = lookup(element(var.roles, count.index), "groups_claim", null)

  backend               = vault_jwt_auth_backend.backend.path
  allowed_redirect_uris = lookup(element(var.roles, count.index), "allowed_redirect_uris", null)

  clock_skew_leeway    = lookup(element(var.roles, count.index), "clock_skew_leeway", 60)
  expiration_leeway    = lookup(element(var.roles, count.index), "expiration_leeway", 60)
  verbose_oidc_logging = lookup(element(var.roles, count.index), "verbose_oidc_logging", null)

  token_ttl               = lookup(element(var.roles, count.index), "token_ttl", null)
  token_max_ttl           = lookup(element(var.roles, count.index), "token_max_ttl", null)
  token_period            = lookup(element(var.roles, count.index), "token_period", null)
  token_policies          = lookup(element(var.roles, count.index), "token_policies", null)
  token_bound_cidrs       = lookup(element(var.roles, count.index), "token_bound_cidrs", null)
  token_explicit_max_ttl  = lookup(element(var.roles, count.index), "token_explicit_max_ttl", null)
  token_no_default_policy = lookup(element(var.roles, count.index), "token_no_default_policy", null)
  token_num_uses          = lookup(element(var.roles, count.index), "token_num_uses", null)
  token_type              = lookup(element(var.roles, count.index), "token_type", null)
}
