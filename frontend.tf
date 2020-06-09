resource "kubernetes_pod" "frontend" {
  metadata {
    name = "frontend-server"
    labels = {
      App = "front-server"
    }
  }

  spec {
    container {
      image = "nginx:1.7.8"
      name  = "example"

      port {
        container_port = 80
      }
    }
  }
}