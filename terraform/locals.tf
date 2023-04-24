locals {
  droplet_public_ip_address = digitalocean_droplet.terraform_droplet.ipv4_address
  droplet_password = nonsensitive(random_password.droplet_password.result)
  droplet = {
        for droplet in digitalocean_droplet.terraform_droplet[*] : droplet.name => {
          fqdn = aws_route53_record.droplet_dns[*].fqdn,
          ip_address = local.droplet_public_ip_address,
          password = local.droplet_password
            }
        }
}