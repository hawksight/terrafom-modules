terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.5.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }
  }
}

provider "kind" {}

provider "kubernetes" {
  host = kind_cluster.default.endpoint

  client_certificate     = kind_cluster.default.client_certificate
  client_key             = kind_cluster.default.client_key
  cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host = kind_cluster.default.endpoint

    client_certificate     = kind_cluster.default.client_certificate
    client_key             = kind_cluster.default.client_key
    cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
  }
}
