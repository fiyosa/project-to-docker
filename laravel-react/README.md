### Features

- vite react
- queue monitor

### run project via docker

```sh
docker compose down -v --rmi all && docker compose build --no-cache --progress plain && docker compose up -d
```

### show worker on linux

```sh
docker exec -it laravel_app ps aux | grep -E "queue:work|schedule:work"
```

```sh
docker exec -it laravel_app ps aux | grep "schedule:work"
```

### show worker on windows

```sh
docker exec -it laravel_app tasklist | findstr "php"
```
