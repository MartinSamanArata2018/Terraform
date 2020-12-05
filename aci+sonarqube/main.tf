terraform {
  required_providers {
    azurerm = {
      version = "~> 2.38.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "sonarqube" {
  name     = "sonarqube"
  location = var.location
}


resource "azurerm_container_group" "sonarqube" {
  name                = "sonarqube"
  location            = azurerm_resource_group.sonarqube.location
  resource_group_name = azurerm_resource_group.sonarqube.name
  ip_address_type     = "public"
  dns_name_label      = "sonarqube-vg"
  os_type             = "linux"

  container {
    name   = "sonarqube"
    image  = "sonarqube:8.5.1-community"
    cpu    = var.cpu
    memory = var.ram

    ports {
      port     = 9000
      protocol = "TCP"
    }
    
    ports {
      port     = 9092
      protocol = "TCP"
    }

    #environment_variables = {
    #  "SONAR_JDBC_URL" = "value"
    #  "SONAR_JDBC_USERNAME" = "value"
    #  "SONAR_JDBC_PASSWORD" = "value"
    #}
  }
}
