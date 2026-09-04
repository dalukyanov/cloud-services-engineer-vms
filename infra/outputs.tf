output "external_ip" {
  description = "Public IP address of the Kittygram VM"
  value       = yandex_compute_instance.kittygram.network_interface[0].nat_ip_address
}

output "kittygram_url" {
  description = "Public Kittygram URL"
  value       = "http://${yandex_compute_instance.kittygram.network_interface[0].nat_ip_address}:${var.gateway_port}"
}

# output "app_bucket_name" {
#   value = yandex_storage_bucket.kittygram.bucket
# }
