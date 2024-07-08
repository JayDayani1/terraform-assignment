terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01655478RG"
    storage_account_name = "tfstaten01655478sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
    access_key           = ""
  }
}
