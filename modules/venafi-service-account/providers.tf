terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.4"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}

# provider "kubernetes" {
#   host = kind_cluster.default.endpoint

#   client_certificate     = kind_cluster.default.client_certificate
#   client_key             = kind_cluster.default.client_key
#   cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
# }
