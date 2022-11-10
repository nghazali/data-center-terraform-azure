# To customise the infrastructure you must provide the value for each of these parameters in config.tfvar

################################################################################
# Common Variables
################################################################################

variable "provider_name" {
  description = "Name of the cloud provider."
  type    = string
  default = "azure"
  validation {
    condition     = contains(["aws", "azure", "gcp"], var.provider_name)
    error_message = "Invalid provider. Valid value is [ aws | azure | gc ]."
  }
}

variable "environment_name" {
  description = "Name for this environment that is going to be deployed. The value will be used to form the name of some resources."
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9\\-]{1,24}$", var.environment_name))
    error_message = "Invalid environment name. Valid name is up to 24 characters starting with lower case alphabet and followed by alphanumerics. '-' is allowed as well."
  }
}


variable "region" {
  description = "Name of the AWS region."
  type        = string
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-[1-9]|eastus", var.region))
    error_message = "Invalid region name. Must be a valid AWS region."
  }
}

variable "resource_tags" {
  description = "Additional tags for all resources to be created."
  default = {
    Terraform = "true"
  }
  type = map(string)
}

# SSH Public Key for Linux VMs
variable "ssh_public_key" {
  default = "~/.ssh/aks-sshkeys-terraform/aks-ssh-key.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"
}
