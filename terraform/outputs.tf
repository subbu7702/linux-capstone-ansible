output "generated_inventory" {
  description = "Path to the generated Ansible inventory"
  value       = local_file.ansible_inventory.filename
}

output "lab_domain" {
  description = "Internal lab domain"
  value       = var.domain
}
