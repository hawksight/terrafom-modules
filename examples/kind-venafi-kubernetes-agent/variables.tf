variable "kind_cluster_name" {
  type        = string
  default     = "venafi"
  description = "The kind cluster name to use"
}

variable "kind_node_image" {
  type        = string
  default     = "kindest/node"
  description = "The image to use for the kind k8s nodes"
}

variable "kind_node_tag" {
  type        = string
  default     = "v1.29.4"
  description = "The image tag to use for the kind k8s nodes"
}

variable "vcp_cluster_name" {
  type        = string
  default     = "terraform-cluster-1"
  description = "Name of the cluster and service account for Venafi Control Planes"
}

variable "vcp_api_key" {
  type        = string
  sensitive   = true
  description = "Venafi API Key"
}

variable "vcp_namespace" {
  type        = string
  default     = "venafi-agent"
  description = "Namespace to install the Venafi Kubernetes Agent in cluster"
}
