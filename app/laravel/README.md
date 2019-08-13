# Пример конфигурации окружения docker приложения laravel

В директори **php** разместите код laravel приложения

```
cp php/.env.example php/.env
cp ./docker/docker-compose-dev.yml ./docker-compose.yml
```

```
make up
./composer install
./artisan key:generate
```




