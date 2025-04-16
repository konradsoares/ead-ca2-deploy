variable "active_droplet_id" {
  description = "Droplet ID to register on the load balancer"
  type        = string
}
variable "active_deployment" {
  description = "Which environment is active (blue or green)"
  type        = string
  default     = "blue"
}
