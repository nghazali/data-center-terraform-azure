
variable "vnet_prefix" {
  type     = string
  description = "Prefix of the resource name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "region" {
  type        = string
  description = "Location of the resource group."
}

variable "subnet_id" {
  type = string
  description = "Subnet ID to be used by rds"
}


variable "vpc_id" {
  type = string
  description = "Virtual network ID to be used by rds"
}

variable "product" {
  type        = string
  description = "Name of the product"
}

variable "db_name" {
  description = "The default DB name of the DB instance."
  validation {
    condition     = var.db_name == null || can(regex("^[a-zA-Z_][a-zA-Z0-9_]*$", var.db_name))
    error_message = "Invalid RDS DB name."
  }
  default = null
  type    = string
}


variable "major_engine_version" {
  description = "RDS Major engine version for the product."
  default     = "11"
  type        = string
  validation {
    condition     = contains(["10", "11", "12", "13"], var.major_engine_version)
    error_message = "Invalid major engine version. Valid ranges are from 10 to 13 (integer)."
  }
}

variable "db_master_username" {
  description = "Master username for the RDS instance."
  type        = string
  default     = null
}

variable "db_master_password" {
  description = "Master password for the RDS instance."
  type        = string
  default     = null
  validation {
    condition     = can(regex("^([aA-zZ]|[0-9]|[!#$%^*(){}?,.]).{8,}$", var.db_master_password)) || var.db_master_password == null
    error_message = "Master password must be at least 8 characters long and can include any printable ASCII character except /, \", @, &, <>, or a space."
  }
}

variable "allocated_storage" {
  description = "The max storage allowed for the PostgreSQL Flexible Server in MB."
  type        = number
}

variable "instance_class" {
  description = "Instance class (SKU name) of the RDS instance."
  type        = string
  default     = "B_Standard_B1ms"
}