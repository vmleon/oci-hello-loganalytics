resource "helm_release" "hello-api" {
  name              = "hello-api"
  chart             = "../helm-charts/hello-api"
  dependency_update = true

  set {
    name  = "oci-la-fluentd.ociLANamespace"
    value = lookup(data.oci_objectstorage_namespace.tenancy_namespace, "namespace")
  }

  set {
    name  = "oci-la-fluentd.ociLALogGroupID"
    value = oci_log_analytics_log_analytics_log_group.logan_log_group.id
  }

  set {
    name  = "oci-la-fluentd.kubernetesClusterID"
    value = oci_containerengine_cluster.oke_cluster.id
  }

  set {
    name  = "oci-la-fluentd.kubernetesClusterName"
    value = "${var.app_name} (${random_string.deploy_id.result})"
  }

  depends_on = [data.oci_containerengine_cluster_kube_config.oke, local_file.oke_kubeconfig]
}
