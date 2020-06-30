resource "google_container_cluster" "cluster1" {
  name               = "cluster1"
  location           = "us-east1-c"
  initial_node_count = 3

  network    = "default"
  subnetwork = "default"
}
