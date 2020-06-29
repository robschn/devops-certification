resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"
    labels = {
      App = "backend"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "backend"
        }
      }
      spec {
        container {
          image = "gcr.io/devops-certification-279819/backend"
          name  = "backend"
          env {
              name = "PORT"
              value = "8080"
          }
          port {
            container_port = 8080
            name = "frontend-port"
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

resource "kubernetes_service" "ClusterIP"{
    metadata {
        name = "backend-service"
    }
    spec {
        selector = {
            App = kubernetes_deployment.backend.spec.0.template.0.metadata[0].labels.App
        }
        port {
            port = "80"
            protocol = "TCP"
            target_port = "8082"
        }
        type = "ClusterIP"
    }
}
