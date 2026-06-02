docker buildx create --use --name openhns-builder
docker buildx build --platform linux/amd64 -t ghcr.io/openhns/games-source-ubuntu24:0.6 --push ./game-ubuntu

Runtime logs behavior:
- Uses regular files/directories only (no symlinks), for better Pterodactyl file manager compatibility.
- Game logs: `/home/container/cstrike/logs`
- Console file log is written from container `stdout/stderr` (same stream as Pterodactyl console).
- Console log path by day: `/home/container/logs/console/YYYY-MM-DD.log`

Egg runtime vars:
- `CONSOLE_LOG` (`0` or `1`)
