
variable "resource_group_name" {
  type        = string
  description = "Resource group Name."
}

variable "region" {
  type        = string
  description = "Location of the resource group."
}

variable "agent_count" {
  type = number
}

variable "cluster_name" {
  type = string
}

variable "dns_prefix" {
  default = "k8s"
}

variable "instance_type" {
  default = "Standard_D2_v2"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "subnet_id" {
  type = string
}

variable "resource_tags" {
  description = "Additional tags for all resources to be created."
  default = {
    Terraform = "true"
  }
  type = map(string)
}

variable "instance_disk_size" {
  description = "Size of the disk attached to the cluster instance."
  default     = 30
  type        = number
}


variable "max_cluster_capacity" {
  description = "Maximum number of EC2 instances that cluster can scale up to."
  type        = number
  default     = 5
  validation {
    condition     = (var.max_cluster_capacity >= 1 && var.max_cluster_capacity <= 20)
    error_message = "Maximum cluster capacity must be between 1 and 20, inclusive."
  }
}

variable "min_cluster_capacity" {
  description = "Minimum number of EC2 instances for the EKS cluster."
  type        = number
  default     = 1
  validation {
    condition     = var.min_cluster_capacity >= 1 && var.min_cluster_capacity <= 20
    error_message = "Minimum cluster capacity must be between 1 and 20, inclusive."
  }
}