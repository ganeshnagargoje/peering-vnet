# This file contains local variables used in the Terraform configuration.
# It defines the subnet IDs and virtual network pairs for peering.
locals {
  subnet_ids = [for s in azurerm_subnet.subnet : s.id]
}

# This local variable defines pairs of virtual networks for peering.
locals {
  vnet_pairs = flatten([
    for i in range(var.vm_count) : [
      for j in range(var.vm_count) : 
        {
          source_index = i
          target_index = j
          name         = "peer-vnet${i + 1}-to-vnet${j + 1}"
        }
      if i != j
    ]
  ])
}
