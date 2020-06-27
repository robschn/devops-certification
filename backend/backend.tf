resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"
    labels = {
      App = "backend"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "Backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "Backend"
        }
      }
      spec {
        container {
          image = "gcr.io/devops-certification-279819/backend:v1.0"
          name  = "backend"

          port {
            container_port = 8082
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
