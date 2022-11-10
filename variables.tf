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

variable "local_helm_charts_path" {
  description = "Path to a local directory with Helm charts to install"
  default     = ""
  type        = string
  validation {
    condition     = can(regex("^[.?\\/?[a-zA-Z0-9|\\-|_]*]*$", var.local_helm_charts_path))
    error_message = "Invalid local Helm chart path."
  }
}


################################################################################
# Confluence variables
################################################################################

variable "confluence_license" {
  description = "Confluence license."
  type        = string
  sensitive   = true
  default     = null
}

variable "confluence_helm_chart_version" {
  description = "Version of confluence Helm chart"
  type        = string
  default     = "1.5.1"
}

variable "confluence_version_tag" {
  description = "Version tag for Confluence"
  type        = string
  default     = null
}

variable "confluence_replica_count" {
  description = "Number of Confluence application nodes"
  type        = number
  default     = 1
  validation {
    condition     = var.confluence_replica_count >= 0
    error_message = "Number of nodes must be greater than or equal to 0."
  }
}

variable "confluence_termination_grace_period" {
  description = "Termination grace period in seconds"
  type        = number
  default     = 30
}

variable "confluence_installation_timeout" {
  description = "Timeout for helm chart installation in minutes"
  type        = number
  default     = 15
}

variable "confluence_install_local_chart" {
  description = "If true installs Confluence using local Helm charts located in local_helm_charts_path"
  default     = false
  type        = bool
}

variable "confluence_cpu" {
  description = "Number of CPUs for confluence instance"
  type        = string
  default     = "1"
}

variable "confluence_mem" {
  description = "Amount of memory for confluence instance"
  type        = string
  default     = "1Gi"
}

variable "confluence_min_heap" {
  description = "Minimum heap size for confluence instance"
  type        = string
  default     = "256m"
  validation {
    condition     = can(regex("^([0-9]){1,5}[k|m|g]$", var.confluence_min_heap))
    error_message = "Minimum heap size for confluence instance is invalid. (Correct form: 1g | 1024m | 2048k)"
  }
}

variable "confluence_max_heap" {
  description = "Maximum heap size for confluence instance"
  type        = string
  default     = "512m"
  validation {
    condition     = can(regex("^([0-9]){1,5}[k|m|g]$", var.confluence_max_heap))
    error_message = "Maximum heap size for confluence instance is invalid. (Correct form: 1g | 1024m | 2048k)"
  }
}

variable "synchrony_cpu" {
  description = "Number of CPUs for synchrony instance"
  type        = string
  default     = "2"
}

variable "synchrony_mem" {
  description = "Amount of memory for synchrony instance"
  type        = string
  default     = "2.5Gi"
}

variable "synchrony_min_heap" {
  description = "Minimum heap size for synchrony instance"
  type        = string
  default     = "1g"
  validation {
    condition     = can(regex("^([0-9]){1,5}[k|m|g]$", var.synchrony_min_heap))
    error_message = "Minimum heap size for synchrony instance is invalid. (Correct form: 1g | 1024m | 2048k)"
  }
}

variable "synchrony_max_heap" {
  description = "Maximum heap size for synchrony instance"
  type        = string
  default     = "2g"
  validation {
    condition     = can(regex("^([0-9]){1,5}[k|m|g]$", var.synchrony_max_heap))
    error_message = "Maximum heap size for synchrony instance is invalid. (Correct form: 1g | 1024m | 2048k)"
  }
}

variable "synchrony_stack_size" {
  description = "Stack size for synchrony instance"
  type        = string
  default     = "2048k"
  validation {
    condition     = can(regex("^([0-9]){1,4}[k|m]$", var.synchrony_stack_size))
    error_message = "Stack size for synchrony instance is invalid. (Correct form: 64m | 2048k)"
  }
}

variable "confluence_local_home_size" {
  description = "Storage size for Confluence local home"
  type        = string
  default     = "10Gi"
}

variable "confluence_db_major_engine_version" {
  description = "The database major version to use for Confluence."
  type        = string
  default     = "11"
}

variable "confluence_db_allocated_storage" {
  description = "Allocated storage for database instance in GiB."
  default     = 1000
  type        = number
}

variable "confluence_db_instance_class" {
  description = "Instance class of the RDS instance."
  default     = "db.t3.micro"
  type        = string
}

variable "confluence_db_iops" {
  description = "The requested number of I/O operations per second that the DB instance can support."
  default     = 1000
  type        = number
}

variable "confluence_db_name" {
  description = "The default DB name of the DB instance."
  default     = "confluence"
  type        = string
}

variable "confluence_collaborative_editing_enabled" {
  description = "If true, Collaborative editing service will be enabled."
  type        = bool
  default     = true
}

variable "confluence_db_snapshot_id" {
  description = "The identifier for the Confluence DB snapshot to restore from."
  default     = null
  type        = string
}

variable "confluence_db_snapshot_build_number" {
  description = "Confluence build number of the database snapshot."
  type        = string
  default     = null
}

variable "confluence_db_master_username" {
  description = "Master username for the Confluence RDS instance."
  type        = string
  default     = null
}

variable "confluence_db_master_password" {
  description = "Master password for the Confluence RDS instance."
  type        = string
  default     = null
}

variable "confluence_shared_home_size" {
  description = "Storage size for Confluence shared home"
  type        = string
  default     = "10Gi"
}

variable "confluence_nfs_requests_cpu" {
  description = "The minimum CPU compute to request for the NFS instance"
  type        = string
  default     = "1"
}

variable "confluence_nfs_requests_memory" {
  description = "The minimum amount of memory to allocate to the NFS instance"
  type        = string
  default     = "1Gi"
}

variable "confluence_nfs_limits_cpu" {
  description = "The maximum CPU compute to allocate to the NFS instance"
  type        = string
  default     = "2"
}

variable "confluence_nfs_limits_memory" {
  description = "The maximum amount of memory to allocate to the NFS instance"
  type        = string
  default     = "2Gi"
}

variable "confluence_shared_home_snapshot_id" {
  description = "EBS Snapshot ID with shared home content."
  type        = string
  default     = null
}