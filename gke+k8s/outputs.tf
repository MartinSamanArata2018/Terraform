# Deployments k8s
output "ip_wp" {
  value = kubernetes_service.wordpress.load_balancer_ingress[0].ip
}

# GKE Cluster
output "client_key" {
  value = google_container_cluster.gke_cluster.master_auth[0].client_key
}

output "client_certificate" {
  value = google_container_cluster.gke_cluster.master_auth[0].client_certificate
}

output "cluster_ca_certificate" {
  value = google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate
}

output "host" {
  value = google_container_cluster.gke_cluster.endpoint
}

output "username" {
  value = google_container_cluster.gke_cluster.master_auth[0].username
}

output "password" {
  value = google_container_cluster.gke_cluster.master_auth[0].password
}