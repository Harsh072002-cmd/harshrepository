rg = {
  westcentral = {
    name     = "rg-webapp-demo"
    location = "West Central US"
  }
}

app_service_plan = {
  plan1 = {
    name    = "westcentral-plan"
    rg_key  = "westcentral"
    os_type = "Windows"
    sku     = "F1"
  }
}

webapp = {
  app1 = {
    name     = "harshwebapp2026demo123"
    rg_key   = "westcentral"
    plan_key = "plan1"
  }
}