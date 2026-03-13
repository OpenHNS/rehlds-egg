#!/bin/bash
set -euo pipefail

cd /home/container || exit 1
chmod +x ./*.sh 2>/dev/null || true

# Unified logs directory for panel users
LOGS_DIR="${LOGS_DIR:-/home/container/logs}"
mkdir -p "${LOGS_DIR}"
ln -sfn /home/container/cstrike/logs "${LOGS_DIR}/cstrike-log"
ln -sfn /home/container/qconsole.log "${LOGS_DIR}/console.log"

# Optional debug mode for ReHLDS/HLDS.
# Adds:
#   -condebug (console to qconsole.log)
#   +syserror_logfile <path> (system error log)
if [[ "${REHLDS_DEBUG_MODE:-0}" == "1" ]]; then
  DEBUG_LOG_FILE="${REHLDS_DEBUG_LOG_FILE:-${LOGS_DIR}/debug.log}"
  STARTUP="${STARTUP} -condebug +syserror_logfile ${DEBUG_LOG_FILE}"
fi

MODIFIED_STARTUP=$(eval echo "${STARTUP}")
echo -e "=> Starting with command:\n${MODIFIED_STARTUP}\n"
exec bash -lc "${MODIFIED_STARTUP}"
