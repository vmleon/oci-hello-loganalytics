resource "oci_log_analytics_log_analytics_log_group" "logan_log_group" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.app_name}-${random_string.deploy_id.result}"
  namespace      = data.oci_objectstorage_namespace.tenancy_namespace.namespace
}
