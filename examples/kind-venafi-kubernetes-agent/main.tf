# --- 1) Create cluster environment
resource "kind_cluster" "default" {
  name       = var.kind_cluster_name
  node_image = "${var.kind_node_image}:${var.kind_node_tag}"
  # Get latest available here: https://hub.docker.com/r/kindest/node/tags
}

# --- 2) Prepare TLSPC svc account crednetial for the agent
module "venafi-service-account" {
  source = "../../modules/venafi-service-account"

  vcp_namespace    = "venafi-agent"
  vcp_team_id      = "d5b8eff0-50af-11ee-91be-f942c7e4bfd2"
  vcp_cluster_name = var.vcp_cluster_name
  vcp_api_key      = var.vcp_api_key
}

# --- 3) Manage the helm release
resource "helm_release" "venafi-agent" {
  name       = "venafi-kubernetes-agent"
  namespace  = var.vcp_namespace
  repository = "oci://registry.venafi.cloud/charts/"
  chart      = "venafi-kubernetes-agent"
  version    = "1.0.0"
  set {
    name  = "config.clientId"
    value = module.venafi-service-account.svc_account_client_id
  }
  set {
    name  = "config.clusterName"
    value = var.vcp_cluster_name
  }
  set {
    name  = "config.clusterDescription"
    value = "Terraform auto installed with svc-account: ${var.vcp_cluster_name}"
  }
  depends_on = [kind_cluster.default, module.venafi-service-account]
}
