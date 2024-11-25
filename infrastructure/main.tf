# Generate a random string to ensure resource uniqueness
resource "random_string" "common" {
  length  = 6
  special = false
  upper   = false
}

# Module to create an Azure resource group
module "resource_group" {
  source        = "./modules/resource_group"
  location      = var.location
  random_suffix = random_string.common.result
}

# Module to create an Azure virtual network (VNet)
module "vnet" {
  source                  = "./modules/vnet"
  resource_group_name     = module.resource_group.resource_group_name
  location                = var.location
  vnet_address_space      = var.vnet_address_space 
  subnet_address_prefixes = var.subnet_address_prefixes
  random_suffix           = random_string.common.result

  depends_on              = [module.resource_group]
}

# Module to create a PostgreSQL database
module "database" {
  source              = "./modules/database"
  resource_group_name = module.resource_group.resource_group_name
  vnet_id             = module.vnet.vnet_id
  location            = var.location
  subnet_id           = module.vnet.subnet_id
  random_suffix       = random_string.common.result
  admin_login    = var.administrator_login
  admin_password = var.administrator_password

  depends_on          = [module.vnet]
}

# Module to create Azure Storage resources
module "storage" {
  source               = "./modules/storage"
  resource_group_name  = module.resource_group.resource_group_name
  location             = var.location
  subnet_id            = module.vnet.subnet_id
  random_suffix        = random_string.common.result

  depends_on           = [module.resource_group, module.vnet]
}

# Module to create an App Service
module "app_service" {
  source              = "./modules/app_service"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  random_suffix       = random_string.common.result
  subnet_id           = module.vnet.subnet_id

  # Pass database connection details to the App Service
  database_host       = module.database.postgresql_host
  database_port       = module.database.postgresql_port
  database_name       = module.database.postgresql_db_name
  database_user       = var.administrator_login
  database_password   = var.administrator_password

  # Pass storage connection details to the App Service
  storage_url         = module.storage.storage_url
  storage_account_id  = module.storage.storage_account_id

  app_service_subnet_id   = module.vnet.app_service_subnet_id # Subnet specifically for App Service

  # Docker configuration for the web app
  docker_image             = var.docker_image
  docker_registry_url      = var.docker_registry_url
  docker_registry_password = var.docker_registry_password
  docker_registry_username = var.docker_registry_username
  
  depends_on          = [module.database, module.storage]
}

# Module to create an Application Gateway
module "gateway" {
  source              = "./modules/gateway"
  gateway_name        = var.gateway_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  subnet_id           = module.vnet.app_gateway_subnet_id

  depends_on          = [module.vnet]
}