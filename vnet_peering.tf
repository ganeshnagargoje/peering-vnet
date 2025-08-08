resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name                = var.vnet1_to_vnet2_peering_name
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}   

resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name                = var.vnet2_to_vnet1_peering_name
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}

resource "azurerm_virtual_network_peering" "peerings" {
  count                      = length(local.vnet_pairs)
  name                       = local.vnet_pairs[count.index].name
  resource_group_name        = azurerm_resource_group.rg.name
  virtual_network_name       = azurerm_virtual_network.vnet[local.vnet_pairs[count.index].source_index].name
  remote_virtual_network_id  = azurerm_virtual_network.vnet[local.vnet_pairs[count.index].target_index].id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
