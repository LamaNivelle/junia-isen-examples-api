variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to"
  type        = string
}

variable "vnet_id" {
    description = "The id of the vnet"
    type        = string
}

variable "subnet_id" {
    description = "The id of the vnet"
    type        = string
}

variable "random_suffix" {
  description = "Random suffix for the name"
  type        = string
}

variable "admin_login" {
  description = "The administrator login for PostgreSQL"
  type        = string
}

variable "admin_password" {
  description = "The administrator password for PostgreSQL"
  type        = string
  sensitive   = true
}