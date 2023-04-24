data "digitalocean_ssh_keys" "rebrain_ssh_key" {
  filter {
    key    = "public_key"
    values = var.rebrain_ssh_public_key
  }
}

data "aws_route53_zone" "rebrain_zone" {
  name = var.rebrain_zone_name
}