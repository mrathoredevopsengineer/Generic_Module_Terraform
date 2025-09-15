variable "sql_database_name" {
  description = "The name of the SQL database."
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server where the database will be created."
  type        = string
}   

variable "resource_group_name" {
  description = "The name of the resource group where the SQL Server is located."
  type        = string
}
