variable "tenancy_ocid" {}

variable "current_user_ocid" {
  default = ""
}

variable "profile" {
  default = ""
}

variable "compartment_ocid" {}

variable "region" {}

provider "oci" {
  region       = var.region
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.current_user_ocid
}

provider "helm" {
  kubernetes {
    host                   = local.cluster_endpoint
    cluster_ca_certificate = local.cluster_ca_certificate
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", local.cluster_id, "--region", local.cluster_region]
      command     = "oci"
    }
  }
}

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 4.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~>2.1.0"
    }
  }
}

locals {
  cluster_endpoint       = yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["clusters"][0]["cluster"]["server"]
  cluster_ca_certificate = base64decode(yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["clusters"][0]["cluster"]["certificate-authority-data"])
  cluster_id             = yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["users"][0]["user"]["exec"]["args"][4]
  cluster_region         = yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["users"][0]["user"]["exec"]["args"][6]
}
