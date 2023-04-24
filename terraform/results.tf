resource "local_file" "droplet_info" {
  content = templatefile("droplet_info.tmpl", 
    {
        ip_addr = local.droplet_public_ip_address
        fqdns = aws_route53_record.droplet_dns.*.fqdn
        passwd = local.droplet_password
    }
  )
  filename = "droplet_info"
}