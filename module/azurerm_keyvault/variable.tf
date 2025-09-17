variable "key_vault_name" {
  type        = string
}
variable "location" {
  type        = string
}

variable "kv_resource_group_name" { 
  type        = string  
  default     = "asnawar"
}