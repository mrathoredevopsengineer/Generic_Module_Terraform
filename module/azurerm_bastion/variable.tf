variable "bastion_name" {
  description = "The name of the Bastion host."
  type        = string
}

variable "location" {
  description = "The Azure region where the Bastion host will be created."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group where the Bastion host will be created."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network where the Bastion host will be deployed."
  type        = string
}



variable "pip_name" {
  description = "The name of the public IP address to associate with the Bastion host."
  type        = string
}
