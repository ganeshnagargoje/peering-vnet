# Create NICs, each pointing to its respective subnet
resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "nic-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-${count.index + 1}"
    subnet_id                     = local.subnet_ids[count.index]
    private_ip_address_allocation = "Dynamic"
  }
}