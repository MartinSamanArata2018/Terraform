resource "kubernetes_service" "wordpress_mysql" {
  metadata {
    name = "wordpress-mysql"

    labels = {
      app = "wordpress"
    }
  }

  spec {
    port {
      port = 3306
    }

    selector = {
      app = "wordpress"

      tier = "mysql"
    }

    cluster_ip = "None"
  }
}

resource "kubernetes_persistent_volume_claim" "mysql_pv_claim" {
  metadata {
    name = "mysql-pv-claim"

    labels = {
      app = "wordpress"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "20Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "wordpress_mysql" {
  metadata {
    name = "wordpress-mysql"

    labels = {
      app = "wordpress"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "wordpress"

        tier = "mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "wordpress"

          tier = "mysql"
        }
      }

      spec {
        volume {
          name = "mysql-persistent-storage"

          persistent_volume_claim {
            claim_name = "mysql-pv-claim"
          }
        }

        container {
          name  = "mysql"
          image = "mysql:5.6"

          port {
            name           = "mysql"
            container_port = 3306
          }

          env {
            name = "MYSQL_ROOT_PASSWORD"

            value_from {
              secret_key_ref {
                name = "mysql-pass"
                key  = "password"
              }
            }
          }

          volume_mount {
            name       = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }
        }
      }
    }

    strategy {
      type = "Recreate"
    }
  }
}

resource "kubernetes_service" "wordpress" {
  metadata {
    name = "wordpress"

    labels = {
      app = "wordpress"
    }
  }

  spec {
    port {
      port = 80
    }

    selector = {
      app = "wordpress"

      tier = "frontend"
    }

    type = "LoadBalancer"
  }
}



resource "kubernetes_persistent_volume_claim" "wp_pv_claim" {
  metadata {
    name = "wp-pv-claim"

    labels = {
      app = "wordpress"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "20Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "wordpress"
    

    labels = {
      app = "wordpress"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "wordpress"

        tier = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "wordpress"

          tier = "frontend"
        }
      }

      spec {
        volume {
          name = "wordpress-persistent-storage"

          persistent_volume_claim {
            claim_name = "wp-pv-claim"
          }
        }


        container {
          name  = "wordpress"
          image = "wordpress:4.8-apache"

          port {
            name           = "wordpress"
            container_port = 80
          }

          env {
            name  = "WORDPRESS_DB_HOST"
            value = "wordpress-mysql"
          }

          env {
            name = "WORDPRESS_DB_PASSWORD"

            value_from {
              secret_key_ref {
                name = "mysql-pass"
                key  = "password"
              }
            }
          }

          volume_mount {
            name       = "wordpress-persistent-storage"
            mount_path = "/var/www/html"
          }
        }
      }
    }

    strategy {
      type = "Recreate"
    }
  }
}

resource "kubernetes_secret" "mysql_pass" {
  metadata {
    name = "mysql-pass"
  }

  data = {
    password = "Contrasenia!"
  }

  type = "Opaque"
}

