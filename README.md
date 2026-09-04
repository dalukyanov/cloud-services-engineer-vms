# Kittygram final: Terraform + CI/CD

Проект разворачивает инфраструктуру в Yandex Cloud через Terraform и деплоит Kittygram на созданную VM через GitHub Actions.

## Состав

- `.github/workflows/terraform.yml` — ручной запуск Terraform: `plan`, `apply`, `destroy`.
- `.github/workflows/deploy.yml` — тесты, сборка Docker-образов, push в Docker Hub, деплой на VM, post-deploy тесты, уведомление в Telegram.
- `infra/` — Terraform-конфигурация: VPC, subnet, Security Group, Compute VM, Object Storage bucket, cloud-init.
- `docker-compose.production.yml` — production-compose для удалённого сервера.
- `tests.yml` — данные для проверки проекта.

## Что создать заранее

До `terraform init` должен существовать S3-бакет для Terraform state в Object Storage. Его имя указывается в секрете `YC_TFSTATE_BUCKET`.

## GitHub Secrets

```text
YC_TOKEN
YC_CLOUD_ID
YC_FOLDER_ID
YC_ZONE
YC_TFSTATE_BUCKET
YC_STORAGE_ACCESS_KEY
YC_STORAGE_SECRET_KEY

SSH_PUBLIC_KEY
SSH_PRIVATE_KEY
VM_USER
APP_BUCKET_NAME

DOCKERHUB_USERNAME
DOCKERHUB_PASSWORD

POSTGRES_DB
POSTGRES_USER
POSTGRES_PASSWORD
DJANGO_SECRET_KEY

TELEGRAM_TOKEN
TELEGRAM_TO
```

Рекомендуемое значение `VM_USER`: `ubuntu`.

## Порядок запуска

1. Создайте бакет для Terraform state.
2. Добавьте GitHub Secrets.
3. Запустите workflow `Terraform` с action `plan`.
4. Запустите workflow `Terraform` с action `apply`.
5. Возьмите `kittygram_url` из output Terraform.
6. Заполните `tests.yml` реальным URL вида `http://<external_ip>:9000`.
7. Сделайте push в `main`, чтобы запустить `.github/workflows/deploy.yml`.

## Проверка на сервере

```bash
ssh ubuntu@<external_ip>
cd /opt/kittygram
sudo docker compose -f docker-compose.production.yml ps
```

## Проверка приложения

```bash
curl http://<external_ip>:9000
curl http://<external_ip>:9000/api/cats/
```
