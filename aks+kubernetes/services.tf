resource "kubernetes_service" "nginx_service" {
  metadata {
    name = "nginx-service"
  }
  spec {
    selector = {
      app = "${kubernetes_deployment.nginx_deployment.metadata.0.labels.app}"
    }
    
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}