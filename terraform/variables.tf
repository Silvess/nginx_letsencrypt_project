variable "do_token" {
    type = string
    description = "DigitalOcean access token"
}

variable "aws_access_key" {
    type = string
    description = "AWS account access key"
}

variable "aws_secret_key" {
    type = string
    description = "AWS account secret key"
}

variable "rebrain_ssh_public_key" {
    type = list
    description = "Existing Rebrain public keys to add to droplet (SSH)"
}

variable "task_name" {
    type = string
    description = "Name of the task in which the droplet is created"
}

variable "user_name" {
    type = string
    description = "User name"
}

variable "user_email" {
    type = string
    description = "Email of the user creating resourses"
}

variable "module" {
    type = string
    description = "Current module (for tagging)"
}

variable "user_public_key_path" {
    type = string
    description = "Path to public SSH key in local filesystem"
}

variable "user_private_key_path" {
    type = string
    description = "Path to private SSH key in local filesystem (for keys without passphrase)"
}

variable "droplet_name" {
    type = string
    description = "Name of droplet"
}

variable "aws_region" {
    type = string
    description = "AWS region to deploy to"
    default = "eu-central-1"
}

variable "rebrain_zone_name" {
    type = string
    description = "Name of DNS zone to create records in"
    default = "devops.rebrain.srwx.net"
}

variable "dns_names" {
  type    = list
  nullable = false
}