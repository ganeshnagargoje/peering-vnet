# create virtual networks for each VM
resource "azurerm_virtual_network" "vnet" {
  count               = var.vm_count
  name                = "${var.prefix}-vnet-${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.${count.index}.0.0/16"]
}
