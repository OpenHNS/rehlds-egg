#!/bin/bash
set -euo pipefail

cd /home/container || exit 1
chmod +x ./*.sh 2>/dev/null || true

LOGS_DIR="${LOGS_DIR:-/home/container/logs}"
mkdir -p "${LOGS_DIR}"
mkdir -p /home/container/cstrike/logs

# Optional debug mode for ReHLDS/HLDS system error logs.
if [[ "${REHLDS_DEBUG_MODE:-0}" == "1" ]]; then
  DEBUG_LOG_FILE="${REHLDS_DEBUG_LOG_FILE:-${LOGS_DIR}/debug.log}"
  mkdir -p "$(dirname "${DEBUG_LOG_FILE}")"
  STARTUP="${STARTUP} +syserror_logfile ${DEBUG_LOG_FILE}"
fi

MODIFIED_STARTUP=$(eval echo "${STARTUP}")
echo -e "=> Starting with command:\n${MODIFIED_STARTUP}\n"

# Optional console file log from stdout/stderr stream.
if [[ "${CONSOLE_LOG:-0}" == "1" ]]; then
  CONSOLE_DIR="${LOGS_DIR}/console"
  CONSOLE_LOG_FILE="${CONSOLE_DIR}/$(date +%Y-%m-%d).log"
  mkdir -p "${CONSOLE_DIR}"
  exec bash -lc "${MODIFIED_STARTUP}" 2>&1 | tee -a "${CONSOLE_LOG_FILE}"
fi

exec bash -lc "${MODIFIED_STARTUP}"
