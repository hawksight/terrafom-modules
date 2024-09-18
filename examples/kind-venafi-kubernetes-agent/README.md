# Venafi Kuberetes Agent in Kind

A reference example of deploying the [venafi-service-account](../../modules/venafi-service-account/) within a kind cluster.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.14.0 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | 0.5.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.14.0 |
| <a name="provider_kind"></a> [kind](#provider\_kind) | 0.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_venafi-service-account"></a> [venafi-service-account](#module\_venafi-service-account) | ../../terraform-modules/venafi-service-account | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.venafi-agent](https://registry.terraform.io/providers/hashicorp/helm/2.14.0/docs/resources/release) | resource |
| [kind_cluster.default](https://registry.terraform.io/providers/tehcyx/kind/0.5.1/docs/resources/cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kind_cluster_name"></a> [kind\_cluster\_name](#input\_kind\_cluster\_name) | The kind cluster name to use | `string` | `"venafi"` | no |
| <a name="input_kind_node_image"></a> [kind\_node\_image](#input\_kind\_node\_image) | The image to use for the kind k8s nodes | `string` | `"kindest/node"` | no |
| <a name="input_kind_node_tag"></a> [kind\_node\_tag](#input\_kind\_node\_tag) | The image tag to use for the kind k8s nodes | `string` | `"v1.29.4"` | no |
| <a name="input_vcp_api_key"></a> [vcp\_api\_key](#input\_vcp\_api\_key) | Venafi API Key | `string` | n/a | yes |
| <a name="input_vcp_cluster_name"></a> [vcp\_cluster\_name](#input\_vcp\_cluster\_name) | Name of the cluster and service account for Venafi Control Planes | `string` | `"terraform-cluster-1"` | no |
| <a name="input_vcp_namespace"></a> [vcp\_namespace](#input\_vcp\_namespace) | Namespace to install the Venafi Kubernetes Agent in cluster | `string` | `"venafi-agent"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_svc_account_client_id"></a> [svc\_account\_client\_id](#output\_svc\_account\_client\_id) | The clientId field from the service account after creation |
| <a name="output_svc_account_private_key"></a> [svc\_account\_private\_key](#output\_svc\_account\_private\_key) | Private key for the service account |
| <a name="output_svc_account_public_key"></a> [svc\_account\_public\_key](#output\_svc\_account\_public\_key) | Public key for the service account |
