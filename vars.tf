variable "vault_address" {
  description = "Origin URL of the Vault server"
  default     = null
}

variable "add_address_to_env" {
  description = "If true the environment variable VAULT_ADDR in the Terraform process environment will be set to the value of the address argument from this provider"
  type        = bool
  default     = false
}

variable "vault_token" {
  description = "Vault token that will be used by Terraform to authenticate. May be set via the VAULT_TOKEN environment variable"
}

variable "token_name" {
  description = "Token name, that will be used by Terraform when creating the child token (display_name)"
  default     = "terraform"
}

variable "ca_cert_file" {
  description = "Path to a file on local disk that will be used to validate the certificate presented by the Vault server"
  default     = null
}

variable "ca_cert_dir" {
  description = "Path to a directory on local disk that contains one or more certificate files that will be used to validate the certificate presented by the Vault server"
  default     = null
}

variable "skip_tls_verify" {
  description = "Set this to true to disable verification of the Vault server's TLS certificate. This is strongly discouraged except in prototype or development environments, since it exposes the possibility that Terraform can be tricked into writing secrets to a server controlled by an intruder"
  default     = false
}

variable "max_lease_ttl_seconds" {
  description = "Used as the duration for the intermediate Vault token Terraform issues itself, which in turn limits the duration of secret leases issued by Vault"
  default     = 1200
}

variable "max_retries" {
  description = "Used as the maximum number of retries when a 5xx error code is encountered"
  default     = 2
}

variable "namespace" {
  description = "Set the namespace to use. May be set via the VAULT_NAMESPACE environment variable. Available only for Vault Enterprise"
  default     = "root"
}

variable "auth_login" {
  description = "A configuration block, described below, that attempts to authenticate using the auth/<method>/login path to aquire a token which Terraform will use. Terraform still issues itself a limited child token using auth/token/create in order to enforce a short TTL and limit exposure"
  type        = list(any)
  default     = []
}

variable "client_auth" {
  description = "A configuration block, described below, that provides credentials used by Terraform to authenticate with the Vault server. At present there is little reason to set this, because Terraform does not support the TLS certificate authentication mechanism"
  type        = list(any)
  default     = []
}

variable "path" {
  description = "Path to mount the JWT/OIDC auth backend"
}

variable "type" {
  description = "Type of auth backend. Should be one of jwt or oidc"
  default     = "jwt"
}

variable "description" {
  description = "The description of the auth backend"
  default     = "Terraform JWT/OIDC auth backend"
}

variable "oidc_discovery_url" {
  description = "The OIDC Discovery URL, without any .well-known component (base path). Cannot be used in combination with jwt_validation_pubkeys"
}

variable "oidc_discovery_ca_pem" {
  description = "The CA certificate or chain of certificates, in PEM format, to use to validate connections to the OIDC Discovery URL. If not set, system certificates are used"
  default     = null
}

variable "oidc_client_id" {
  description = "Client ID used for OIDC backends"
}

variable "oidc_client_secret" {
  description = "Client Secret used for OIDC backends"
}

variable "jwks_url" {
  description = "JWKS URL to use to authenticate signatures. Cannot be used with oidc_discovery_url or jwt_validation_pubkeys"
  default     = null
}

variable "jwks_ca_pem" {
  description = "The CA certificate or chain of certificates, in PEM format, to use to validate connections to the JWKS URL. If not set, system certificates are used"
  default     = null
}

variable "jwt_validation_pubkeys" {
  description = "A list of PEM-encoded public keys to use to authenticate signatures locally. Cannot be used in combination with oidc_discovery_url"
  default     = null
}

variable "jwt_supported_algs" {
  description = "A list of supported signing algorithms. Vault 1.1.0 defaults to [RS256] but future or past versions of Vault may differ"
  type        = list(string)
  default     = null
}

variable "bound_issuer" {
  description = "The value against which to match the iss claim in a JWT"
  default     = null
}

variable "default_role" {
  description = "The default role to use if none is provided during login"
}

variable "tune" {
  description = "Extra configuration block (https://www.terraform.io/docs/providers/vault/r/jwt_auth_backend.html#tune)"
  type        = list(map(any))
  default     = []
}

variable "roles" {
  description = "Vault JWT auth roles (https://www.terraform.io/docs/providers/vault/r/jwt_auth_backend_role.html)"
  type        = list(any)
  default     = []
}
