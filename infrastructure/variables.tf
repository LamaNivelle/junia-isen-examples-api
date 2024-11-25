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

variable "gateway_name" {
    description = "Name of the gateway"
    type = string  
    default = "ccp-gateway"
}

variable "administrator_login" {
  description = "The administrator login for the PostgreSQL database"
  type        = string
}

variable "administrator_password" {
  description = "The administrator password for the PostgreSQL database"
  type        = string
}

variable "docker_registry_url" {
  description = "The administrator password for the PostgreSQL database"
  type        = string
  default     = "https://ghcr.io/"
}

variable "docker_image" {
  description = "The administrator password for the PostgreSQL database"
  type        = string
  default     = "ghcr.io/htocqueville/junia-isen-examples-api:latest"
}

variable "docker_registry_password" {
  description = "The administrator password for the PostgreSQL database"
  type        = string
}

variable "docker_registry_username" {
  description = "The administrator password for the PostgreSQL database"
  type        = string
}