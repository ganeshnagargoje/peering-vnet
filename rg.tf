resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location  
}

# resource "azurerm_virtual_network" "vnet1" {
#   name                = var.vnet1_name
#   address_space       = [var.vnet1_address_space]
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# resource "azurerm_subnet" "subnet1" {
#   name                 = var.subnet1_name
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet1.name
#   address_prefixes     = [var.subnet1_address_prefix]
# }


# resource "azurerm_virtual_network" "vnet2" {
#   name                = var.vnet2_name
#   address_space       = [var.vnet2_address_space]
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# resource "azurerm_subnet" "subnet2" {
#   name                 = var.subnet2_name
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet2.name
#   address_prefixes     = [var.subnet2_address_prefix]
# }