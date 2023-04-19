provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "example" {
    name     = "${var.prefix}-resources"
    location = var.location
}

resource "azurerm_service_plan" "example" {
    name                = "${var.prefix}-sp"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    os_type             = "Linux"
    sku_name            = "S1"
}

module "my-app" {
    source                  = "github.com/dmitrygrinko/azure-cloud-utilities//modules/app-service/linux-nodejs?ref=main"
    app_name                = "my-app"
    resource_group_location = azurerm_resource_group.example.location
    resource_group_name     = azurerm_resource_group.example.name
    service_plan_id         = azurerm_service_plan.example.id
}
