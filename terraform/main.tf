terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "local" {}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/generated_inventory.ini"

  content = <<-EOT
    [dns]
    vm2 ansible_host=${var.dns_ip}
 
    [web]
    vm3 ansible_host=${var.web_ip}
  EOT
}
