provider "yandex" {
  service_account_key = var.yc_service_account_key
  cloud_id            = var.yc_cloud_id
  folder_id           = var.yc_folder_id
  zone                = var.yc_zone
}
