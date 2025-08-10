# Create VMs
resource "azurerm_virtual_machine" "vm" {
  count                = var.vm_count
  name                 = "${var.prefix}-vm${count.index + 1}"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]
  vm_size              = var.vm_size
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vm${count.index + 1}"
    admin_username = "adminuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/adminuser/.ssh/authorized_keys"
      key_data = azurerm_key_vault_secret.ssh_public_key.value
    }
  }

  # Ensure Key Vault secrets are created before VM creation
  depends_on = [
    azurerm_key_vault_secret.ssh_public_key,
    azurerm_key_vault_access_policy.key_vault_access_policy
  ]
}