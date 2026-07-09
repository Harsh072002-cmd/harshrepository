# Resource Group

resource "azurerm_resource_group" "rg" {

  for_each = var.rg

  name     = each.value.name
  location = each.value.location

}

# Virtual Network

resource "azurerm_virtual_network" "vnet" {

  for_each = var.virtual_network

  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  address_space = each.value.address_space

}

# Subnet

resource "azurerm_subnet" "subnet" {

  for_each = var.subnet

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.rg[each.value.rg_key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.vnet_key].name

  address_prefixes = each.value.address_prefixes

}

# Network Security Group

resource "azurerm_network_security_group" "nsg" {

  for_each = var.network_security_group

  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

}

# RDP Rule

resource "azurerm_network_security_rule" "rdp" {

  for_each = var.network_security_group

  name = "Allow-RDP"

  priority = 100

  direction = "Inbound"

  access = "Allow"

  protocol = "Tcp"

  source_port_range = "*"

  destination_port_range = "3389"

  source_address_prefix = "*"

  destination_address_prefix = "*"

  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  network_security_group_name = azurerm_network_security_group.nsg[each.key].name

}

# Public IP

resource "azurerm_public_ip" "pip" {

  for_each = var.public_ip

  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  allocation_method = each.value.allocation_method

  sku = each.value.sku

}

# Network Interface

resource "azurerm_network_interface" "nic" {

  for_each = var.network_interface

  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  ip_configuration {

    name = "internal"

    subnet_id = azurerm_subnet.subnet[each.value.subnet_key].id

    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.pip[each.value.public_ip_key].id

  }

}

# Associate NSG with Subnet

resource "azurerm_subnet_network_security_group_association" "association" {

  for_each = var.subnet

  subnet_id = azurerm_subnet.subnet[each.key].id

  network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg_key].id

}

# Storage Account

resource "azurerm_storage_account" "storage" {

  for_each = var.storage_account

  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  account_tier = each.value.account_tier

  account_replication_type = each.value.account_replication_type

}

# Get Current Azure Client

data "azurerm_client_config" "current" {}

# Key Vault

resource "azurerm_key_vault" "kv" {

  for_each = var.key_vault

  name = each.value.name

  location = azurerm_resource_group.rg[each.value.rg_key].location

  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = each.value.sku_name

  purge_protection_enabled = each.value.purge_protection_enabled

  soft_delete_retention_days = each.value.soft_delete_retention_days

}

##############################################################
# Windows Virtual Machine
##############################################################

resource "azurerm_windows_virtual_machine" "vm" {

  for_each = var.windows_vm

  name = each.value.name

  location = azurerm_resource_group.rg[each.value.rg_key].location

  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  size = each.value.size

  admin_username = each.value.admin_username

  admin_password = each.value.admin_password

  computer_name = each.value.computer_name

  network_interface_ids = [

    azurerm_network_interface.nic[each.value.nic_key].id

  ]

  provision_vm_agent = true

  patch_mode = "AutomaticByPlatform"

  os_disk {

    caching = "ReadWrite"

    storage_account_type = "StandardSSD_LRS"

  }

  source_image_reference {

    publisher = "MicrosoftWindowsServer"

    offer = "WindowsServer"

    sku = "2025-datacenter-azure-edition"

    version = "latest"

  }

}