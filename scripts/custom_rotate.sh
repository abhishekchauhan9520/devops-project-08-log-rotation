#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="${1:-config/myapp.logrotate}"
STATE_FILE="${2:-/run/logrotate/myapp.status}"

if ! command -v logrotate >/dev/null 2>&1; then
    echo "logrotate is required but was not found" >&2
    exit 127
fi

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Configuration file not found: $CONFIG_FILE" >&2
    exit 2
fi

mkdir -p "$(dirname "$STATE_FILE")"

if [[ -e "$STATE_FILE" ]]; then
    logrotate -s "$STATE_FILE" "$CONFIG_FILE"
else
    logrotate -s "$STATE_FILE" -f "$CONFIG_FILE"
fi
