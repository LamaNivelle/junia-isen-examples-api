variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "France Central"
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "App Service subnet address space"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_name" {
  description = "App Service subnet name"
  type        = string
  default     = "app-service-subnet"
}

variable "web_app_name" {
  description = "Nom de la Web App"
  type        = string
}

variable "gateway_name" {
    description = "Name of the gateway"
    type = string  
    default = "ccp-gateway"
}