variable "cluster_kube_config_expiration" {
  default = 2592000
}

variable "cluster_kube_config_token_version" {
  default = "2.0.0"
}

data "oci_containerengine_cluster_kube_config" "oke" {
  #Required
  cluster_id = oci_containerengine_cluster.oke_cluster.id

  #Optional
  expiration    = var.cluster_kube_config_expiration
  token_version = var.cluster_kube_config_token_version

  depends_on = [oci_containerengine_node_pool.oke_node_pool]
}