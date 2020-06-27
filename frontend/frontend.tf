resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"
    labels = {
      App = "frontend"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        App = "frontend"
      }
    }
    template {
      metadata {
        labels = {
          App = "frontend"
        }
      }
      spec {
        container {
          image = "gcr.io/devops-certification-279819/frontend:v1.0"
          name  = "frontend"
          env {
              name = "PORT"
              value = "80"
          }
          env {
              name = "SERVER"
              value = "http://backend-service"
          }
          port {
            container_port = 80
            name = "backend-port"
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

resource "kubernetes_service" "LoadBalancer" {
    metadata {
        name = "frontend-service"
    }
    spec {
        selector = {
            App = kubernetes_deployment.frontend.spec.0.template.0.metadata[0].labels.App
        }
        port {
            port = "80"
            protocol = "TCP"
            target_port = "8080"
        }
        type = "LoadBalancer"
    }
}