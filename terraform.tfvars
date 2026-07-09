# Resource Group

rg = {

  westus2 = {

    name = "rg-devops-demo"

    location = "West US 2"

  }

}

# Virtual Network

virtual_network = {

  vnet1 = {

    name = "vnet-devops"

    rg_key = "westus2"

    address_space = ["10.0.0.0/16"]

  }

}

# Subnet

subnet = {

  subnet1 = {

    name = "default-subnet"

    rg_key = "westus2"

    vnet_key = "vnet1"

    nsg_key = "nsg1"

    address_prefixes = ["10.0.1.0/24"]

  }

}

# Network Security Group

network_security_group = {

  nsg1 = {

    name = "nsg-devops"

    rg_key = "westus2"

  }

}

# Public IP

public_ip = {

  pip1 = {

    name = "pip-devops"

    rg_key = "westus2"

    allocation_method = "Static"

    sku = "Standard"

  }

}

# Network Interface

network_interface = {

  nic1 = {

    name = "nic-devops"

    rg_key = "westus2"

    subnet_key = "subnet1"

    public_ip_key = "pip1"

  }

}

# Storage Account

storage_account = {

  storage1 = {

    name = "harshstorage20260709abc1"

    rg_key = "westus2"

    account_tier = "Standard"

    account_replication_type = "LRS"

  }

}

# Key Vault

key_vault = {

  kv1 = {

    name = "harsh-kv-demo-2026"

    rg_key = "westus2"

    sku_name = "standard"

    soft_delete_retention_days = 7

    purge_protection_enabled = false

  }

}

# Windows Virtual Machine

windows_vm = {

  vm1 = {

    name = "windows-vm"

    rg_key = "westus2"

    nic_key = "nic1"

    size = "Standard_D2s_v3"

    admin_username = "azureadmin"

    admin_password = "Password@12345"

    computer_name = "windowsvm"

  }

}

