resource "helm_release" "hello-api" {
  name       = "hello-api"
  chart      = "../helm-charts/hello-api"

  depends_on = [data.oci_containerengine_cluster_kube_config.oke, local_file.oke_kubeconfig]
}