variable "app_name" {
  default     = "LA Monitoring"
}

variable "cluster_workers_visibility" {
  default     = "Private"
  description = "The Kubernetes worker nodes that are created will be hosted in public or private subnet(s)"

  validation {
    condition     = var.cluster_workers_visibility == "Private" || var.cluster_workers_visibility == "Public"
    error_message = "Sorry, but cluster visibility can only be Private or Public."
  }
}

variable "cluster_endpoint_visibility" {
  default     = "Public"
  description = "The Kubernetes cluster that is created will be hosted on a public subnet with a public IP address auto-assigned or on a private subnet. If Private, additional configuration will be necessary to run kubectl commands"

  validation {
    condition     = var.cluster_endpoint_visibility == "Private" || var.cluster_endpoint_visibility == "Public"
    error_message = "Sorry, but cluster endpoint visibility can only be Private or Public."
  }
}

variable "cluster_name" {
  default = "oke_monitoring"
}

variable "availability_domain" {
  default = 3
}

variable "cluster_options_add_ons_is_kubernetes_dashboard_enabled" {
  default = false
}

variable "cluster_options_add_ons_is_tiller_enabled" {
  default = false
}

variable "network_cidrs" {
  type = map(string)

  default = {
    VCN-CIDR                      = "10.20.0.0/16"
    SUBNET-REGIONAL-CIDR          = "10.20.10.0/24"
    LB-SUBNET-REGIONAL-CIDR       = "10.20.20.0/24"
    ENDPOINT-SUBNET-REGIONAL-CIDR = "10.20.0.0/28"
    ALL-CIDR                      = "0.0.0.0/0"
    PODS-CIDR                     = "10.244.0.0/16"
    KUBERNETES-SERVICE-CIDR       = "10.96.0.0/16"
  }
}

variable "node_pool_name" {
  default     = "pool1"
  description = "Name of the node pool"
}

variable "k8s_version" {
  default     = "Latest"
  description = "Kubernetes version installed on your master and worker nodes"
}

variable "num_pool_workers" {
  default     = 3
  description = "The number of worker nodes in the node pool. If select Cluster Autoscaler, will assume the minimum number of nodes configured"
}

variable "node_pool_shape" {
  default     = "VM.Standard.E3.Flex"
  description = "A shape is a template that determines the number of OCPUs, amount of memory, and other resources allocated to a newly created instance for the Worker Node"
}

variable "node_pool_node_shape_config_ocpus" {
  default     = "1" # Only used if flex shape is selected
  description = "You can customize the number of OCPUs to a flexible shape"
}

variable "node_pool_node_shape_config_memory_in_gbs" {
  default     = "16" # Only used if flex shape is selected
  description = "You can customize the amount of memory allocated to a flexible shape"
}

variable "node_pool_boot_volume_size_in_gbs" {
  default     = "60"
  description = "Specify a custom boot volume size (in GB)"
}

variable "image_operating_system" {
  default     = "Oracle Linux"
  description = "The OS/image installed on all nodes in the node pool."
}

variable "image_operating_system_version" {
  default     = "7.9"
  description = "The OS/image version installed on all nodes in the node pool."
}

variable "generate_public_ssh_key" {
  default = true
}

variable "public_ssh_key" {
  default     = ""
  description = "In order to access your private nodes with a public SSH key you will need to set up a bastion host (a.k.a. jump box). If using public nodes, bastion is not needed. Left blank to not import keys."
}