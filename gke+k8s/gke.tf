# Cluster GKE
resource "google_container_cluster" "gke_cluster" {
  name     = "${var.prefix}-gke"
  location = var.location_gke

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    username = "admin"
    password = "admin"

    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

# Pool de nodos
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.gke_cluster.name}-node-pool"
  location   = var.location_gke
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.numero_nodos

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    preemptible  = true
    machine_type = var.machine_type_gke
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

