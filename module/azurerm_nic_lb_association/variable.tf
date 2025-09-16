variable "nic_name" {
  description = "The name of the Network Interface"
  type        = string      
  
}

variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
}

variable "lb_BackEndAddressPool_name" {
  description = "The name of the Load Balancer BackEnd Address Pool"
  type        = string  
  
}