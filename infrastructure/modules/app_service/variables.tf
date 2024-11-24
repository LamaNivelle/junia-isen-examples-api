variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to"
  type        = string
}

variable "web_app_name" {
  description = "The name of the web app"
  type        = string
}

variable "random_suffix" {
  description = "Suffixe aléatoire pour les noms des ressources"
  type        = string
}

variable "database_host" {
  description = "The host of the PostgreSQL database"
  type        = string
}

variable "database_port" {
  description = "The port of the PostgreSQL database"
  type        = number
}

variable "database_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "database_user" {
  description = "The user for connecting to the PostgreSQL database"
  type        = string
}

variable "database_password" {
  description = "The password for the PostgreSQL database user"
  type        = string
}

variable "storage_url" {
  description = "The URL of the storage account"
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the storage account"
  type        = string
}

variable "subnet_id" {
  description = "The subnet id"
  type        = string
}

variable "app_service_subnet_id" {
  description = "The ID of the subnet for the App Service"
  type        = string
}

variable "docker_registry_url" {
  description = "The docker registery url"
  type        = string
}

variable "docker_image" {
  description = "The docker image"
  type        = string
}

variable "docker_registry_password" {
  description = "The docker registry password"
  type        = string
}

variable "docker_registry_username" {
  description =  "The docker registery username"
  type        = string
}