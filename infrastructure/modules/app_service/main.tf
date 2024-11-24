# Define an Azure Service Plan for hosting the App Service
resource "azurerm_service_plan" "service_plan" {
  name                = "ccp-service-plan-${var.random_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B3"
}

# Define an Azure Linux Web App and creation process (App Service)
resource "azurerm_linux_web_app" "web_app" {
  name                = "ccp-web-app-${var.random_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  virtual_network_subnet_id = var.app_service_subnet_id
  
  # Application settings (environment variables for the web app)
  app_settings = {
    # Database environment variables
    DATABASE_HOST     = var.database_host
    DATABASE_PORT     = var.database_port
    DATABASE_NAME     = var.database_name
    DATABASE_USER     = var.database_user
    DATABASE_PASSWORD = var.database_password

    STORAGE_ACCOUNT_URL = var.storage_url # URL for the associated Azure Storage account
  }

  # Site configuration (specifies the application stack, e.g., Docker container details)
  site_config {
    application_stack {
      docker_registry_url      = var.docker_registry_url
      docker_image_name        = var.docker_image
      docker_registry_password = var.docker_registry_password
      docker_registry_username = var.docker_registry_username
    }
  }

  # Enable a system-assigned managed identity for the web app
  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_service_plan.service_plan]
}

# Assign the web app's managed identity a role to access blob storage
resource "azurerm_role_assignment" "app_service_storage_access" {
  principal_id         = azurerm_linux_web_app.web_app.identity[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = var.storage_account_id
}