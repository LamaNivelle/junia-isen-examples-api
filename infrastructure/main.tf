resource "random_string" "common" {
  length  = 6
  special = false
  upper   = false
}

module "resource_group" {
    source              = "./modules/resource_group"
    location            = var.location
    random_suffix       = random_string.common.result
}

module "vnet" {
  source                   = "./modules/vnet"
  resource_group_name      = module.resource_group.resource_group_name
  location                 = var.location
  vnet_address_space       = var.vnet_address_space 
  subnet_address_prefixes  = var.subnet_address_prefixes
  random_suffix       = random_string.common.result

  depends_on = [module.resource_group]
}

module "database" {
  source              = "./modules/database"
  resource_group_name = module.resource_group.resource_group_name
  vnet_id             = module.vnet.vnet_id
  location            = var.location
  subnet_id           = module.vnet.subnet_id
  random_suffix       = random_string.common.result

  depends_on = [module.resource_group, module.vnet]
}

module "app_service" {
  source              = "./modules/app_service"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  web_app_name        = var.web_app_name
  random_suffix       = random_string.common.result

  depends_on = [module.resource_group]
}

module "storage" {
  source               = "./modules/storage"
  resource_group_name  = module.resource_group.resource_group_name
  location             = var.location
  subnet_id            = module.vnet.subnet_id
  principal_id         = module.app_service.identity_principal_id
  random_suffix       = random_string.common.result

  depends_on = [module.resource_group, module.app_service]
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