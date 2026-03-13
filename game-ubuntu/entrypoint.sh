#!/bin/bash
set -euo pipefail

cd /home/container || exit 1
chmod +x ./*.sh 2>/dev/null || true

# Pterodactyl file manager may not handle symlinks well.
# Keep logs in regular directories/files.
LOGS_DIR="${LOGS_DIR:-/home/container/logs}"
mkdir -p "${LOGS_DIR}"
mkdir -p /home/container/cstrike/logs

# Optional debug mode for ReHLDS/HLDS.
# Adds:
#   -condebug (console to qconsole.log)
#   +syserror_logfile <path> (system error log)
if [[ "${REHLDS_DEBUG_MODE:-0}" == "1" ]]; then
  DEBUG_LOG_FILE="${REHLDS_DEBUG_LOG_FILE:-${LOGS_DIR}/debug.log}"
  CONSOLE_LOG_FILE="${REHLDS_CONSOLE_LOG_FILE:-${LOGS_DIR}/console.log}"
  mkdir -p "$(dirname "${DEBUG_LOG_FILE}")"
  mkdir -p "$(dirname "${CONSOLE_LOG_FILE}")"
  touch "${CONSOLE_LOG_FILE}"

  # Mirror qconsole.log into a regular file under /home/container/logs.
  # This avoids symlink issues in Pterodactyl file manager.
  (tail -n +1 -F /home/container/qconsole.log >> "${CONSOLE_LOG_FILE}" 2>/dev/null) &

  STARTUP="${STARTUP} -condebug +syserror_logfile ${DEBUG_LOG_FILE}"
fi

MODIFIED_STARTUP=$(eval echo "${STARTUP}")
echo -e "=> Starting with command:\n${MODIFIED_STARTUP}\n"
exec bash -lc "${MODIFIED_STARTUP}"
