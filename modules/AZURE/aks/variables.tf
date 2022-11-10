

variable "resource_group_name" {
  type = string
}

variable "region" {
  type        = string
  description = "Location of the resource group."
}

variable "agent_count" {
  default = 2
}

# The following two variable declarations are placeholder references.
# Set the values for these variable in terraform.tfvars
variable "aks_service_principal_app_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

variable "cluster_name" {
  default = "k8stest"
}

variable "dns_prefix" {
  default = "k8stest"
}

variable "instance_type" {
  default = "Standard_D2_v2"
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}
