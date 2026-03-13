docker buildx create --use --name openhns-builder
docker buildx build --platform linux/amd64 -t ghcr.io/openhns/games-source-ubuntu24:0.3 --push ./game-ubuntu

Runtime logs behavior:
- Uses regular files/directories only (no symlinks), for better Pterodactyl file manager compatibility.
- Game logs: `/home/container/cstrike/logs`
- Debug log (`+syserror_logfile`): `/home/container/logs/debug.log`
- Console log mirror: `/home/container/logs/console.log` (from `qconsole.log`)

Egg runtime vars:
- `REHLDS_DEBUG_MODE` (`0` or `1`)
- `REHLDS_DEBUG_LOG_FILE` (default `/home/container/logs/debug.log`)
- `REHLDS_CONSOLE_LOG_FILE` (default `/home/container/logs/console.log`)

When `REHLDS_DEBUG_MODE=1`, startup adds:
- `-condebug`
- `+syserror_logfile <REHLDS_DEBUG_LOG_FILE>`
