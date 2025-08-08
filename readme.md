---

# 🔗 Create Peering Between Two Virtual Networks (VNet Peering)

This Terraform project demonstrates how to create **bidirectional VNet peering** between two virtual networks in Azure. VNet peering allows traffic between virtual machines (VMs) in different VNets as if they were part of the same network, enabling secure communication across regions or resource groups.

---

## ✅ Requirements Overview

| **Step** | **Resource**                       | **Description**                                                      |
| -------- | ---------------------------------- | -------------------------------------------------------------------- |
| 1        | Create Virtual Network 1 (`vnet1`) | Define the first virtual network.                                    |
| 2        | Create Subnet (`subnet1`)          | Add a subnet to `vnet1`.                                             |
| 3        | Create Virtual Network 2 (`vnet2`) | Define the second virtual network.                                   |
| 4        | Create Subnet (`subnet2`)          | Add a subnet to `vnet2`.                                             |
| 5        | Create Peering `vnet1 ➜ vnet2`     | Configure peering from `vnet1` to `vnet2`.                           |
| 6        | Create Peering `vnet2 ➜ vnet1`     | Configure peering from `vnet2` to `vnet1`.                           |
| 7        | Use `variables.tf`                 | Parameterize values such as names, CIDRs, regions, etc.              |
| 8        | Create Bastion Host                | Use Terraform to deploy a Bastion Host for secure VM access.         |
| 9        | Use `count` and `count.index`      | Deploy multiple VMs dynamically using `count` and `count.index`.     |
| 10       | Generate & Store SSH Keys          | Manually create SSH keys and store them securely in Azure Key Vault. |

---

## 🛠️ Technologies Used

* **Terraform**
* **Azure Virtual Network**
* **Azure Bastion**
* **Azure Key Vault** (for SSH key storage)
* **Azure Virtual Machines** (with `count`)
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
├── vm-nic.tf
├── keyvault.tf
```

---

## 🚀 How It Works

1. Two VNets (`vnet1`, `vnet2`) are created in the same or different regions.
2. Each VNet contains a dedicated subnet (`subnet1`, `subnet2`).
3. Bidirectional peering is established between the two VNets.
4. A Bastion Host is provisioned to securely access VMs without public IPs.
5. VMs are deployed using `count` to demonstrate scalable resource creation.
6. SSH keys are manually created and stored in Azure Key Vault.
7. Public SSH key is retrieved from Key Vault and injected into each VM via `os_profile_linux_config`.

---

## 🔐 Manual SSH Key Creation and Azure Key Vault Storage

### ✅ Step 1: Generate SSH Key Pair Locally

Run the following command on your terminal (Linux/macOS/WSL):

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/azure-vm-key -C "adminuser"
```

This will generate:

* **Private Key**: `~/.ssh/azure-vm-key`
* **Public Key**: `~/.ssh/azure-vm-key.pub`

> 💡 Do **not** check in your private key to source control!

---

### ✅ Step 2: Upload Public Key to Azure Key Vault

Use Azure CLI to upload the `.pub` key:

```bash
az keyvault secret set \
  --vault-name "<your-keyvault-name>" \
  --name "ssh-public-key" \
  --file ~/.ssh/azure-vm-key.pub
```

---

### ✅ Step 3: Access SSH Key in Terraform

In `keyvault.tf`:

```hcl
data "azurerm_key_vault" "example" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rg
}

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ssh-public-key"
  key_vault_id = data.azurerm_key_vault.example.id
}
```

Then in your `vm.tf`:

```hcl
os_profile_linux_config {
  disable_password_authentication = true

  ssh_keys {
    path     = "/home/adminuser/.ssh/authorized_keys"
    key_data = data.azurerm_key_vault_secret.ssh_public_key.value
  }
}
```

---

## 📌 Example Variable Usage

```hcl
variable "vnet1_address_space" {
  default = "10.0.0.0/16"
}

variable "vnet2_address_space" {
  default = "10.1.0.0/16"
}

variable "keyvault_name" {}
variable "keyvault_rg" {}
```

---

## ✅ Best Practices

* Use separate modules for networking, compute, and security.
* Store sensitive secrets (like SSH keys) in Azure Key Vault.
* Do **not** store private keys in Terraform files or Git.
* Use `count` and `for_each` to scale and manage infrastructure easily.
* Enable VNet peering options like:

  * `allow_virtual_network_access = true`
  * `allow_forwarded_traffic = true`
  * `use_remote_gateways = false` (customizable)

---
