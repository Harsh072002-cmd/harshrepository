resource "azurerm_resource_group" "rg" {
  for_each = var.rg

  name     = each.value.name
  location = each.value.location
}

# App Service Plan

resource "azurerm_service_plan" "plan" {
  for_each = var.app_service_plan

  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  os_type  = each.value.os_type
  sku_name = each.value.sku
}

# Windows Web App

resource "azurerm_windows_web_app" "webapp" {
  for_each = var.webapp

  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.rg_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.rg_key].name

  service_plan_id = azurerm_service_plan.plan[each.value.plan_key].id

  site_config { always_on = false }
}