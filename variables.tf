variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group_name" {
  type = string
  default = "peering-rg"
}

variable "vnet1_name" {
    type = string
    default = "vnet1"
}
variable "vnet2_name" {
    type = string
    default = "vnet2"
}
variable "vnet1_address_space" {
    type = string
    default = "10.0.0.0/16"
}
variable "vnet2_address_space" {
    type = string
    default = "10.1.0.0/16"
}
variable "subnet1_name" {
    type = string
    default = "subnet1"
}
variable "subnet2_name" {
    type = string
    default = "subnet2"
}
variable "subnet1_prefix" {
    type = string
    default = "10.0.1.0/24"
}
variable "subnet2_prefix" {
    type = string
    default = "10.1.1.0/24"
}

variable "vm_count" {
  default = 2
}

variable "bastion_name" {
    type = string
    default = "bastion"
}

variable "subnet1_address_prefix" {
    type = string
    default = "10.0.1.0/24"

}

variable "subnet2_address_prefix" {
    type = string
    default = "10.1.1.0/24"

}

variable "vnet1_to_vnet2_peering_name" {
    type = string
    default = "peer1to2"
  
}

variable "vnet2_to_vnet1_peering_name" {
    type = string
    default = "peer2to1"
}

# used for the prefix of the VM and NIC names 
variable "prefix" {
  type    = string
  default = "lrn"
  
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
  
}