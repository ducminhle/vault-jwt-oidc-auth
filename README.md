# Terraform JWT/OIDC auth backend role Module

Terraform module used to manage JWT/OIDC auth in a Vault server.

### Prerequisites
```
Terraform >= v0.12.16
```

### Description

- Provides a resource for managing an JWT auth backend within Vault and JWT/OIDC auth backend role.

### Input
| Name | Description | Type | Default | Required | Example
|------|-------------|:----:|:-----:|:-----:|:-----:|
| vault_address | Origin URL of the Vault server | string | `null` | yes | `https://vault.example.net:8200` |
| add_address_to_env | The name of the policy. | bool | `false` | no | `true` |
| vault_token | The name of the policy. | string |  | yes | `x.ejroeitjeSEU` |
| token_name | Token name, that will be used by Terraform when creating the child token (display_name) | string | `terraform` | no | `root-token` |
| ca_cert_file | Path to a file on local disk that will be used to validate the certificate presented by the Vault server | string | `null` | no | `/path/ca.cert` |
| ca_cert_dir | Path to a directory on local disk that contains one or more certificate files that will be used to validate the certificate presented by the Vault server | string | `null` | no | `/path` |
| skip_tls_verify | Set this to true to disable verification of the Vault server's TLS certificate. This is strongly discouraged except in prototype or development environments, since it exposes the possibility that Terraform can be tricked into writing secrets to a server controlled by an intruder | boolean | `false` | yes | `true` |
| max_lease_ttl_seconds | Used as the duration for the intermediate Vault token Terraform issues itself, which in turn limits the duration of secret leases issued by Vault | number | `1200` | no | `30` |
| max_retries | Used as the maximum number of retries when a 5xx error code is encountered. | number | `2` | no | `3` |
| namespace | Set the namespace to use. May be set via the VAULT_NAMESPACE environment variable. Available only for Vault Enterprise | string | `root` | no | `root` |
| auth_login | A configuration block, described below, that attempts to authenticate using the auth/<method>/login path to aquire a token which Terraform will use. Terraform still issues itself a limited child token using auth/token/create in order to enforce a short TTL and limit exposure | list(map(any)) | `[]` | no | [{"path"="userpass: auth/userpass/login/:username","namespace"="root","parameters"={"a"="b","c"="d"}}] |
| client_auth | A configuration block, described below, that provides credentials used by Terraform to authenticate with the Vault server. At present there is little reason to set this, because Terraform does not support the TLS certificate authentication mechanism | list(map(any)) | `[]` | no | [{"cert_file"="/path/ca.cert","key_file"="/path/key"}]|
| path | Path to mount the JWT/OIDC auth backend | string | | yes | `oidc` |
| type | Type of auth backend. Should be one of jwt or oidc | string | `jwt` | yes | `oidc` |
| description | The description of the auth backend | string | `Terraform JWT/OIDC auth backend` | no | `Terraform JWT/OIDC auth backend` |
| oidc_discovery_url | The OIDC Discovery URL, without any .well-known component (base path). Cannot be used in combination with jwt_validation_pubkeys | string |  | yes | `https://gitlab.com` |
| oidc_discovery_ca_pem | The CA certificate or chain of certificates, in PEM format, to use to validate connections to the OIDC Discovery URL. If not set, system certificates are used | string | `null` | no |  |
| oidc_client_id | Client ID used for OIDC backends | string |  | yes | `wafojwjofo` |
| oidc_client_secret | Client Secret used for OIDC backends | string |  | yes | `eoiwajf9wjafioj` |
| jwks_url | JWKS URL to use to authenticate signatures. Cannot be used with oidc_discovery_url or jwt_validation_pubkeys | string | `null` | no | `oidc` |
| jwks_ca_pem | The CA certificate or chain of certificates, in PEM format, to use to validate connections to the JWKS URL. If not set, system certificates are used | string | `null` | no | `/path/ca.pem` |
| jwt_validation_pubkeys | A list of PEM-encoded public keys to use to authenticate signatures locally. Cannot be used in combination with oidc_discovery_url | string | `null` | no |  |
| jwt_supported_algs | A list of supported signing algorithms. Vault 1.1.0 defaults to [RS256] but future or past versions of Vault may differ | list(string) | `null` | no |  |
| bound_issuer | The value against which to match the iss claim in a JWT | string | `null` | no | `localhost` |
| default_role | The default role to use if none is provided during login | string |  | no | `reader` |
| tune | Extra configuration block (https://www.terraform.io/docs/providers/vault/r/jwt_auth_backend.html#tune) | list(map(any)) | `[]` | no |  |
| roles | Vault JWT auth roles (https://www.terraform.io/docs/providers/vault/r/jwt_auth_backend_role.html) | list(any) | `[]` | no |  |


### Outputs

| Name | Description |
|------|-------------|
| auth_path | Path to mount the JWT/OIDC auth backend |
| oidc_discovery_url | The OIDC Discovery URL, without any .well-known component (base path). Cannot be used in combination with jwt_validation_pubkeys |
| role_names | List role names created |

### Authors

* **Le Minh Duc** - *Initial work* - [Le Minh Duc](minhducle.it@gmail.com)
