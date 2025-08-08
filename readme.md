---

# 🔗 Create Peering Between Two Virtual Networks (VNet Peering)

This Terraform project demonstrates how to create **bidirectional VNet peering** between two virtual networks in Azure. VNet peering allows traffic between virtual machines (VMs) in different VNets as if they were part of the same network, enabling secure communication across regions or resource groups.

---

## ✅ Requirements Overview

| **Step** | **Resource**                       | **Description**                                                  |
| -------- | ---------------------------------- | ---------------------------------------------------------------- |
| 1        | Create Virtual Network 1 (`vnet1`) | Define the first virtual network.                                |
| 2        | Create Subnet (`subnet1`)          | Add a subnet to `vnet1`.                                         |
| 3        | Create Virtual Network 2 (`vnet2`) | Define the second virtual network.                               |
| 4        | Create Subnet (`subnet2`)          | Add a subnet to `vnet2`.                                         |
| 5        | Create Peering `vnet1 ➜ vnet2`     | Configure peering from `vnet1` to `vnet2`.                       |
| 6        | Create Peering `vnet2 ➜ vnet1`     | Configure peering from `vnet2` to `vnet1`.                       |
| 7        | Use `variables.tf`                 | Parameterize values such as names, CIDRs, regions, etc.          |
| 8        | Create Bastion Host                | Use Terraform to deploy a Bastion Host for secure VM access.     |
| 9        | Use `count` and `count.index`      | Deploy multiple VMs dynamically using `count` and `count.index`. |

---

## 🛠️ Technologies Used

* **Terraform**
* **Azure Virtual Network**
* **Azure Bastion**
* **Azure Virtual Machines**
* **VNet Peering**

---

## 📁 File Structure (Suggested)

```
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── vnet_peering.tf
├── bastion.tf
├── vm.tf
```

---

## 🚀 How It Works

1. Two VNets (`vnet1`, `vnet2`) are created in the same or different regions.
2. Each VNet contains a dedicated subnet (`subnet1`, `subnet2`).
3. Bidirectional peering is established between the two VNets.
4. A Bastion Host is provisioned to securely access VMs without public IPs.
5. VMs are deployed using `count` to showcase scalable resource creation.

---

## 📌 Example Variable Usage

```hcl
variable "vnet1_address_space" {
  default = "10.0.0.0/16"
}

variable "vnet2_address_space" {
  default = "10.1.0.0/16"
}
```

---

## ✅ Best Practices

* Use separate modules for networking, compute, and security.
* Parameterize all configurable values via variables.
* Use `count` and `for_each` for scalable and repeatable infrastructure.
* Enable peering options like `allow_forwarded_traffic`, `use_remote_gateways` as needed.


