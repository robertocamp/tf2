## Meta
variable "meta" {
  description = "meta data"
  default     = {}
}

## Networking Service
variable "networking_module" {
  description = "various VPC network setttings"
  default     = {}
}

## Apps
variable "apps" {
  description = "settings for provisioned apps"
  default     = {}
}