variable "do_token" {}
variable "active_droplet_id" {}
variable "inactive_droplet_id" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_loadbalancer" "www_lb" {
  name   = "www-lb"
  region = "ams3"

  droplet_ids = [var.active_droplet_id, var.inactive_droplet_id]

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"
    target_port    = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 9090 # Only the active node should respond to this
    protocol = "tcp"
  }
}
