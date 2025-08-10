#Store SSH Keys in Key Vault as Secrets
resource "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ssh-public-key"
  value        = file("my-ssh-key.pub")
  key_vault_id = azurerm_key_vault.kv.id
  
  depends_on = [
    azurerm_key_vault_access_policy.key_vault_access_policy
  ]
}

resource "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "ssh-private-key"
  value        = file("my-ssh-key")
  key_vault_id = azurerm_key_vault.kv.id
  
  depends_on = [
    azurerm_key_vault_access_policy.key_vault_access_policy
  ]
}
