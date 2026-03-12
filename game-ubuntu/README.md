docker buildx create --use --name openhns-builder

docker buildx build --platform linux/amd64 -t ghcr.io/openhns/games-source-ubuntu24:0.2 --push ./
