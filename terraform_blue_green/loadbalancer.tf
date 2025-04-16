# Lookup existing load balancer by name
data "digitalocean_loadbalancer" "existing_lb" {
  name = "www-lb"
}

# Update it with new droplet
resource "digitalocean_loadbalancer" "update_lb" {
  provider = digitalocean
  name     = data.digitalocean_loadbalancer.existing.name
  region   = data.digitalocean_loadbalancer.existing.region

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

  lifecycle {
    ignore_changes = [name, region, forwarding_rule, healthcheck]
  }
}
