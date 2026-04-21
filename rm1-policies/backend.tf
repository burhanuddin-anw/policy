terraform {
  backend "azurerm" {
    resource_group_name   = "rg-rm1-terraform-state"
    storage_account_name  = "strm1terraformstate"
    container_name        = "terraform-state"
    key                   = "terraform.tfstate"
  }
}