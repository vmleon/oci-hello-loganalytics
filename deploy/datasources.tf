data "oci_containerengine_cluster_option" "oke" {
  cluster_option_id = "all"
}

data "oci_containerengine_node_pool_option" "oke" {
  node_pool_option_id = "all"
}

data "oci_core_images" "node_pool_images" {
  compartment_id = var.tenancy_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "7.9"
  shape                    = "VM.Standard.E3.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

data "oci_core_services" "all_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

resource "random_string" "deploy_id" {
  length  = 4
  special = false
}

locals {
  app_name_normalized = substr(replace(lower(var.app_name), " ", "-"), 0, 6)
}