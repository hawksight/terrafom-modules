resource "kubernetes_namespace" "agent" {
  metadata {
    name = var.vcp_namespace
  }
}

# ED25519 key
resource "tls_private_key" "agent" {
  algorithm = "ED25519"
}

resource "kubernetes_secret" "credentials" {
  metadata {
    name      = "agent-credentials"
    namespace = var.vcp_namespace
  }
  data = {
    "privatekey.pem" = tls_private_key.agent.private_key_pem
  }
  type       = "kubernetes.io/opaque"
  depends_on = [kubernetes_namespace.agent]
}

locals {
  # Create the data blob to be sent to TLS in the next call
  create_svc_data = jsonencode({
    "name" : var.vcp_cluster_name,
    "owner" : var.vcp_team_id,
    "scopes" : [
      "kubernetes-discovery"
    ],
    "credentialLifetime" : 365,
    "publicKey" : tls_private_key.agent.public_key_pem,
    "authenticationType" : "rsaKey"
  })
  depends_on = [tls_private_key.agent]
}

resource "terraform_data" "tlspc" {
  triggers_replace = [
    tls_private_key.agent
  ]
  # Provision a svc account in TLSPC
  provisioner "local-exec" {
    when    = create
    command = <<-EOT
    # Can't use --fail-with-body because of version of curl in HCP
    # curl -s --fail-with-body --request POST \
    curl -s --fail --request POST \
      --url https://api.venafi.cloud/v1/serviceaccounts \
      --header "accept: application/json" \
      --header "content-type: application/json" \
      --header "tppl-api-key: $VCP_API_KEY" \
      -d "$DATA"
    if [ $? -eq 0 ] ; then
      exit 0
    else
      exit 1
    fi
    EOT
    environment = {
      VCP_API_KEY = nonsensitive(trimspace(var.vcp_api_key))
      DATA        = local.create_svc_data
    }
    interpreter = ["/bin/bash", "-c"]
  }
  depends_on = [local.create_svc_data]
}

data "external" "uuid_check" {
  program = ["bash", "${path.module}/scripts/svc-account-get-uuid.sh"]
  query = {
    VCP_CLUSTER_NAME = var.vcp_cluster_name
    VCP_API_KEY      = var.vcp_api_key
  }
  depends_on = [terraform_data.tlspc]
}
