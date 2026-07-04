variable "rg" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "app_service_plan" {
  type = map(object({
    name    = string
    rg_key  = string
    os_type = string
    sku     = string
  }))
}

variable "webapp" {
  type = map(object({
    name     = string
    rg_key   = string
    plan_key = string
  }))
}