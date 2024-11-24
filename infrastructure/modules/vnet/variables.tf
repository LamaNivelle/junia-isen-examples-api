variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the Virtual Network"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "random_suffix" {
  description = "Random suffix for the names"
  type        = string
}