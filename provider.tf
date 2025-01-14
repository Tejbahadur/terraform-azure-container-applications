terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.15.0"  
    }
  }
#   required_version = ">= 3.0.2"
}

provider "azurerm" {
  features {
    
  }
}