#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_ROOT="$ROOT/tests/fixtures/run"
LOG_DIR="$TEST_ROOT/logs"
STATE_FILE="$TEST_ROOT/logrotate.status"
CONFIG_FILE="$TEST_ROOT/myapp.logrotate"

rm -rf "$TEST_ROOT"
mkdir -p "$LOG_DIR"

cat > "$CONFIG_FILE" <<CFG
$LOG_DIR/*.log {
    daily
    rotate 2
    missingok
    notifempty
    compress
    delaycompress
    copytruncate
}
CFG

printf 'line 1\nline 2\n' > "$LOG_DIR/app.log"

bash -n "$ROOT/scripts/custom_rotate.sh"
logrotate -f -s "$STATE_FILE" "$CONFIG_FILE"

test -f "$LOG_DIR/app.log"
test -f "$LOG_DIR/app.log.1"
test "$(wc -c < "$LOG_DIR/app.log")" -ge 1

printf 'Project 08 log rotation smoke test passed.\n'
