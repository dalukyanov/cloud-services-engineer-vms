provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone

  storage_access_key = var.storage_access_key
  storage_secret_key = var.storage_secret_key
}
