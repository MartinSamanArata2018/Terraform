output "ip_prometheus" {
  value = kubernetes_service.prometheus_service.load_balancer_ingress[0].ip
}

output "ip_wp" {
  value = kubernetes_service.wordpress.load_balancer_ingress[0].ip
}