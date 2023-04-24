resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.yml.tmpl", 
    {
        ip_addr = local.droplet_public_ip_address
        vmname = digitalocean_droplet.terraform_droplet.name
    }
  )
  filename = "../inventory/inventory.yml"

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i \"${self.filename}\" --private-key ${var.user_private_key_path} ../nginx.yml"
  }
}