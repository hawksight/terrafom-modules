output "svc_account_public_key" {
  value       = trimspace(tls_private_key.agent.public_key_pem)
  sensitive   = false
  description = "Public key for the service account"
  depends_on  = []
}

output "svc_account_private_key" {
  value       = trimspace(tls_private_key.agent.private_key_pem)
  sensitive   = true
  description = "Private key for the service account"
  depends_on  = []
}

output "svc_account_client_id" {
  value       = data.external.uuid_check.result.uuid
  sensitive   = false
  description = "The clientId field from the service account after creation"
}
