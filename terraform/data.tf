data "aws_secretsmanager_secret_version" "porkbun_apis" {
    secret_id = "porkbun_apis"
}

# Use locals to grab the decrypted key from secret manager
locals {
    apis = jsondecode(
        data.aws_secretsmanager_secret_version.porkbun_apis.secret_string
    )
}