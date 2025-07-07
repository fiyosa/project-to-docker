```sh
docker compose down --rmi all && docker compose build --no-cache --progress plain && docker compose up -d
```

ps aux | grep "queue:work"
