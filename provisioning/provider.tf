variable "tenancy_ocid" {}

variable "current_user_ocid" {
  default = ""
}

variable "profile" {}

variable "compartment_ocid" {}

variable "region" {}

provider "oci" {
  region              = var.region
  auth                = "SecurityToken"
  config_file_profile = var.profile
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
