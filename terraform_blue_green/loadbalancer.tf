
locals {
  blue_droplet_id  = 489128393
  green_droplet_id = 489128482
  active_droplet   = var.active_deployment == "blue" ? local.blue_droplet_id : local.green_droplet_id
}

resource "digitalocean_loadbalancer" "www-lb" {
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

  droplet_ids = [local.active_droplet]
}
