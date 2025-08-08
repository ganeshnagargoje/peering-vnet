# create subnets for each virtual network
resource "azurerm_subnet" "subnet" {
  count                = var.vm_count
  name                 = "${var.prefix}-subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet[count.index].name
  address_prefixes     = ["10.${count.index}.1.0/24"]
}
