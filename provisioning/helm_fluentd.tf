resource "helm_release" "fluentd" {
  name       = "fluentd"
  chart      = "../helm-charts/fluentd"

  values = ["${file("../helm-charts/fluentd/values.yaml")}"]

  set {
    name  = "image.url"
    value = "fra.ocir.io/fruktknlrefu/fluentd_oci_la:20220307"
  }

  set {
    name  = "ociLANamespace"
    value = lookup(data.oci_objectstorage_namespace.tenancy_namespace, "namespace")
  }

  set {
    name  = "ociLALogGroupID"
    value = var.log_analytics_log_group_id
  }

  set {
    name  = "kubernetesClusterID"
    value = oci_containerengine_cluster.oke_cluster.id
  }

  set {
    name  = "kubernetesClusterName"
    value = "${var.app_name} (${random_string.deploy_id.result})"
  }

  depends_on = [data.oci_containerengine_cluster_kube_config.oke, local_file.oke_kubeconfig]
}