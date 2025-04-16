resource "digitalocean_loadbalancer" "www_lb" {
  name   = "www-lb"
  region = "ams3"

  droplet_ids = [
    var.blue_droplet_id,
    var.green_droplet_id
  ]

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = var.target_env == "blue" ? 80 : 81
    protocol = "tcp"
  }
}
