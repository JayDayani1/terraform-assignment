provider "azurerm" {
  features {}
  tenant_id = "77b2a71c-04cd-4fa4-adcb-b134c80e4a0c"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.54.0"
    }
  }
  required_version = ">= 1.4.6, < 2.0.0"
}
