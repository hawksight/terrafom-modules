output "svc_account_public_key" {
  value       = module.venafi-service-account.svc_account_public_key
  sensitive   = false
  description = "Public key for the service account"
  depends_on  = []
}

output "svc_account_private_key" {
  value       = module.venafi-service-account.svc_account_private_key
  sensitive   = true
  description = "Private key for the service account"
  depends_on  = []
}

output "svc_account_client_id" {
  value       = module.venafi-service-account.svc_account_client_id
  sensitive   = false
  description = "The clientId field from the service account after creation"
}
