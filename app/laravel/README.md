# Example php application configuration

In the ** php ** directory, place the application code

```
cp php/.env.example php/.env
cp ./docker/docker-compose-dev.yml ./docker-compose.yml
```

```
make up
./composer install
./artisan key:generate
```




