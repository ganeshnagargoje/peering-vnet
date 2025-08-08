output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "object_id" {
  value = data.azurerm_client_config.current.object_id
  
}
output "vnets" {
  value = azurerm_virtual_network.vnet[*].id
}

output "subnet" {
  value = azurerm_subnet.subnet[*].id
}
output "NICs" {
  value = azurerm_network_interface.nic[*].id  
}

output "VMs" {
  value = azurerm_virtual_machine.vm[*].id
}


output "ssh_public_key" {
  value = azurerm_key_vault_secret.ssh_public_key.value
}

output "ssh_private_key" {
  value = azurerm_key_vault_secret.ssh_private_key.value
}