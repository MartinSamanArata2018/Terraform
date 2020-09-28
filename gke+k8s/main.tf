terraform {
  required_providers {
    google = {
      version = "~> 3.40.0"
    }
    kubernetes = {
      version = "~> 1.13.2"
    }
  }
}

provider "google" {
}

provider "kubernetes" {
  host                   = google_container_cluster.gke_cluster.endpoint
  username               = google_container_cluster.gke_cluster.master_auth[0].username
  password               = google_container_cluster.gke_cluster.master_auth[0].password
  client_certificate     = base64decode(google_container_cluster.gke_cluster.master_auth[0].client_certificate)
  client_key             = base64decode(google_container_cluster.gke_cluster.master_auth[0].client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate)
}
