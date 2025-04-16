locals {
  raw_node    = trim(file("${path.module}/.env"))
  active_node = contains(["ACTIVE_NODE=blue", "ACTIVE_NODE=green"], local.raw_node) ? replace(local.raw_node, "ACTIVE_NODE=", "") : "blue"
}

resource "digitalocean_loadbalancer" "www_lb" {
  name   = "www-lb"
  region = "ams3"
  droplet_ids = ["489128393", "489128482"] # Both always attached

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 80
    target_protocol = "http"
    # Traffic will be routed by health checks or tags
  }

  healthcheck {
    protocol = "http"
    port     = 80
    path     = "/health-${local.active_node}"
  }
}
