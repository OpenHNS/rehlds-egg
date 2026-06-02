#!/bin/bash
set -euo pipefail

cd /home/container || exit 1
chmod +x ./*.sh 2>/dev/null || true

LOGS_DIR="${LOGS_DIR:-/home/container/logs}"
mkdir -p "${LOGS_DIR}"
mkdir -p /home/container/cstrike/logs

MODIFIED_STARTUP=$(eval echo "${STARTUP}")
echo -e "=> Starting with command:\n${MODIFIED_STARTUP}\n"

# Optional console file log from stdout/stderr stream.
if [[ "${CONSOLE_LOG:-0}" == "1" ]]; then
  CONSOLE_DIR="${LOGS_DIR}/console"
  CONSOLE_LOG_FILE="${CONSOLE_DIR}/$(date +%Y-%m-%d).log"
  mkdir -p "${CONSOLE_DIR}"
  # Use redirection via process substitution instead of a pipeline.
  # This keeps process handling compatible with Pterodactyl stop actions.
  exec > >(tee -a "${CONSOLE_LOG_FILE}") 2>&1
fi

exec bash -lc "${MODIFIED_STARTUP}"
