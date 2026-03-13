docker buildx create --use --name openhns-builder
docker buildx build --platform linux/amd64 -t ghcr.io/openhns/games-source-ubuntu24:0.3 --push ./game-ubuntu

Runtime logs behavior:
- `/home/container/logs/cstrike-log` -> `/home/container/cstrike/logs`
- `/home/container/logs/console.log` -> `/home/container/qconsole.log`

Egg runtime vars:
- `REHLDS_DEBUG_MODE` (`0` or `1`)
- `REHLDS_DEBUG_LOG_FILE` (default `/home/container/logs/debug.log`)

When `REHLDS_DEBUG_MODE=1`, startup adds:
- `-condebug`
- `+syserror_logfile <REHLDS_DEBUG_LOG_FILE>`
