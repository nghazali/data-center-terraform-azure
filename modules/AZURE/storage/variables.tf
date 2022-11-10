variable "resource_group_name" {
  type = string
}

variable "region" {
  type = string
}

variable "maximum_size" {
  type    = number
  default = 100
}

variable "product" {
  type        = string
  description = "Name of the product"
}


variable "shared_home_size" {
  description = "The storage capacity to allocate to shared home"
  type        = string
  validation {
    condition     = can(regex("^[0-9]+([gG]|Gi)$", var.shared_home_size))
    error_message = "Invalid shared home persistent volume size. Should be a number followed by 'Gi' or 'g'."
  }
}

variable "namespace" {
  description = "Kubernetes namespace to install NFS server."
  type        = string
}
