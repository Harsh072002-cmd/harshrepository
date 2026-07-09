# Resource Group

variable "rg" {
  description = "Resource Group"

  type = map(object({
    name     = string
    location = string
  }))
}


# Virtual Network

variable "virtual_network" {
  description = "Virtual Network"

  type = map(object({
    name          = string
    rg_key        = string
    address_space = list(string)
  }))
}


# Subnet

variable "subnet" {

  description = "Subnet"

  type = map(object({

    name = string

    rg_key = string

    vnet_key = string

    nsg_key = string

    address_prefixes = list(string)

  }))
}

# Network Security Group

variable "network_security_group" {

  description = "Network Security Group"

  type = map(object({

    name   = string
    rg_key = string

  }))
}


# Public IP

variable "public_ip" {

  description = "Public IP"

  type = map(object({

    name              = string
    rg_key            = string
    allocation_method = string
    sku               = string

  }))
}


# Network Interface


variable "network_interface" {

  description = "Network Interface"

  type = map(object({

    name          = string
    rg_key        = string
    subnet_key    = string
    public_ip_key = string

  }))
}

# Storage Account


variable "storage_account" {

  description = "Storage Account"

  type = map(object({

    name                     = string
    rg_key                   = string
    account_tier             = string
    account_replication_type = string

  }))
}

# Key Vault


variable "key_vault" {

  description = "Azure Key Vault"

  type = map(object({

    name                       = string
    rg_key                     = string
    sku_name                   = string
    soft_delete_retention_days = number
    purge_protection_enabled   = bool

  }))
}

# Windows Virtual Machine

variable "windows_vm" {

  description = "Windows Virtual Machine"

  type = map(object({

    name    = string
    rg_key  = string
    nic_key = string

    size = string

    admin_username = string
    admin_password = string

    computer_name = string

  }))
}