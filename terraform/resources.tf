resource "digitalocean_ssh_key" "user_ssh_key" {
  name       = "${var.user_email}-ssh-key"
  public_key = file(var.user_public_key_path)
}

resource "random_password" "droplet_password" {
  override_special = "!%()-_=+<>:?"
  length = 12
}

resource "digitalocean_droplet" "terraform_droplet" {
  image  = "ubuntu-20-04-x64"
  name   = "${var.droplet_name}-${var.user_name}"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_keys.rebrain_ssh_key.ssh_keys[0].id,
    digitalocean_ssh_key.user_ssh_key.id
  ]
  tags = [
    "task_name:${var.task_name}",
    "user_email:${var.user_email}",
    "module:${var.module}"
  ]

  connection {
    type     = "ssh"
    host     = self.ipv4_address
    # При использовании ключа с пассфразой, используем ssh-agent, а из блока connection удаляем определение private_key (https://github.com/hashicorp/terraform/issues/24898).    
    # При использовании ключа без пассфразы, можно указать ключ в виде:
    # private_key = file(var.user_private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"root:${local.droplet_password}\" | chpasswd"
    ]
  }
}

resource "aws_route53_record" "droplet_dns" {
  count = length(var.dns_names)
  zone_id = data.aws_route53_zone.rebrain_zone.zone_id
  name    = "${var.dns_names[count.index]}"
  type    = "A"
  ttl     = 300
  records = [local.droplet_public_ip_address]
}








