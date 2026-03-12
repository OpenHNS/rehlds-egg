#!/bin/bash
set -euo pipefail

cd /home/container || exit 1
chmod +x ./*.sh 2>/dev/null || true

MODIFIED_STARTUP=$(eval echo "${STARTUP}")
echo -e "=> Starting with command:\n${MODIFIED_STARTUP}\n"
exec bash -lc "${MODIFIED_STARTUP}"
