variable "tenancy_ocid" {}

variable "user_ocid" {}

variable "current_user_ocid" {
  default = ""
}

variable "fingerprint" {}

variable "private_key_path" {}

variable "compartment_ocid" {}

variable "region" {}

provider "oci" {
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.current_user_ocid != "" ? var.current_user_ocid : var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

provider "helm" {
  kubernetes {
    config_path = "${path.module}/generated/kubeconfig"
  }
}

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 4.0"
    }
  }
}
