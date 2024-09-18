variable "vcp_namespace" {
  type        = string
  default     = "venafi-agent"
  description = "The namespace where the agent is deployed"
}

variable "vcp_api_key" {
  type        = string
  sensitive   = true
  description = "Venafi API Key"
}

variable "vcp_team_id" {
  type        = string
  sensitive   = false
  description = "Venafi Team UID"
}

variable "vcp_cluster_name" {
  type        = string
  sensitive   = false
  description = "Venafi Cluster & Service Account friendly name"
}
