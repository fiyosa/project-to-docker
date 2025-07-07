## run project via docker

```sh
docker compose down --rmi all && docker compose build --no-cache --progress plain && docker compose up -d
```

## show worker on linux

```sh
ps aux | grep -E "queue:work|schedule:work"
```

```sh
ps aux | grep "schedule:work"
```

## show worker on windows

```sh
tasklist | findstr "php"
```
