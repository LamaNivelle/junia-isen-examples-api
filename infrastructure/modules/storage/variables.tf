variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to"
  type        = string
}

variable "subnet_id" {
    description = "The id of the vnet"
    type        = string
}

variable "role_definition_name" {
  description = "Azure role name to attribute"
  type        = string
  default     = "Storage Blob Data Contributor"
}

variable "random_suffix" {
  description = "Random suffix for the names"
  type        = string
}