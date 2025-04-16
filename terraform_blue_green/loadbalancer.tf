locals {
  updated_droplets = [var.active_droplet_id]
}

resource "digitalocean_loadbalancer" "www_lb" {
  name   = "www-lb"
  region = "ams3"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = local.updated_droplets
}
