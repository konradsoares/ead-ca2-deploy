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

  droplet_ids = [var.active_droplet_id]
}
