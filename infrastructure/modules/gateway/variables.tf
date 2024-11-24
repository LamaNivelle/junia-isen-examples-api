variable "gateway_name" {
    description="Name of the gateway"
    type = string
}

variable "resource_group_name"{
    description="The name of the resource group in Azure"
    type = string
}

variable "location" {
    description = "Location of the Azure resources"
    type = string
}

variable "subnet_id" {
  description = "The subnet id"
  type=string
}