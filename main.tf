
resource "azurerm_resource_group" "rg" {
  name = var.rgname
  location = var.rglocation
}

resource "azurerm_log_analytics_workspace" "alaw" {
  name = var.log_analytics_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_container_app_environment" "acae" {
  name = var.container_app_environment_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.alaw.id  
}

resource "azurerm_container_app" "aca" {
  name                         = var.container_app
  container_app_environment_id = azurerm_container_app_environment.acae.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Multiple"

  template {
    container {
      name   = var.container.name
      image  = var.container.image
      cpu    = var.container.cpu
      memory = var.container.memory
    }
    revision_suffix = "python-container"
    max_replicas = 3
    min_replicas = 1
  }
  
  ingress {
    allow_insecure_connections = true
    traffic_weight {
      percentage = 100
      revision_suffix = "python-container"
    }
    target_port = 5000
    external_enabled = true
  }
}

output "azurerm_container_app_url" {
  value = azurerm_container_app.aca.latest_revision_fqdn
}

output "azurerm_container_app_revision_name" {
  value = azurerm_container_app.aca.latest_revision_name
  
}

output "azurerm_container_app_location" {
  value = azurerm_container_app.aca.location
}

output "azurerm_container_app_public_ip" {
  value = azurerm_container_app.aca.outbound_ip_addresses
}