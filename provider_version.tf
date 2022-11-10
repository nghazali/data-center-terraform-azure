# Define the required providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    kubernetes = {
      version = "~> 2.7"
    }
    helm = {
      version = "~> 2.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
