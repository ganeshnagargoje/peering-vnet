resource "azurerm_key_vault" "kv" {
  name                        = "lrn-vm-ssh-kv"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
  enabled_for_disk_encryption = true
  enabled_for_deployment      = true
  enabled_for_template_deployment = true

  lifecycle {
    ignore_changes = [
      access_policy
    ]
  }
}

# Create access policy using for_each to ensure idempotent behavior
resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  for_each = var.create_access_policy ? toset([data.azurerm_client_config.current.object_id]) : toset([])
  
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"   
  ]

  depends_on = [azurerm_key_vault.kv]
}