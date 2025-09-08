variable "bastion_subnet_name" {
  description = "The name of the Bastion subnet."
  type        = string
  default     = "AzureBastionSubnet"
}
variable "rg_name" {
  description = "The name of the resource group where the Bastion subnet will be created."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network where the Bastion subnet will be created."
  type        = string
}