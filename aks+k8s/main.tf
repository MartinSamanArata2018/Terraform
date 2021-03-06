terraform {
  required_providers {
    azurerm = {
      version = "~> 2.29.0"
    }
    kubernetes = {
      version = "~> 1.13.2"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  username               = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
  password               = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
}
