output "blob_storage_account_name" {
  description = "The name of the account for the blob storage"
  value = azurerm_storage_account.blob_storage.name
}

output "blob_container_name" {
  description = "The name of the blob container"
  value = azurerm_storage_container.blob_container.name
}

output "storage_url" {
  description = "URL to connect to the storage account"
  value = azurerm_storage_account.blob_storage.primary_blob_endpoint
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.blob_storage.id
}