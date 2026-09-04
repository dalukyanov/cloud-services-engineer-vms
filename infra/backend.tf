terraform {
  required_version = ">= 1.6.3"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.126.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    # Значение переопределяется в GitHub Actions через backend-config.
    # Бакет для state должен быть создан заранее, до terraform init.
    bucket = "kittygram-tfstate-vladimirgentov"
    region = "ru-central1"
    key    = "kittygram/tf-state.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
