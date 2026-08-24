# Project 08 — Automate Log Rotation

A practical Linux log-rotation example using `logrotate`, a reusable Bash wrapper, and an isolated smoke test.

## What it demonstrates

- Daily rotation with seven retained rotations
- Compression with delayed compression
- `missingok` and `notifempty` safety behavior
- `copytruncate` for applications that keep files open
- Repeatable rotation through a Bash wrapper
- An isolated end-to-end test that never touches system logs

## Layout

```text
config/myapp.logrotate
scripts/custom_rotate.sh
tests/test_logrotation.sh
docs/USAGE.md
```

## Install

Copy `config/myapp.logrotate` to `/etc/logrotate.d/myapp` on a Debian/Ubuntu host and create `/var/log/myapp` for the application.

## Manual rotation

```bash
sudo logrotate -d /etc/logrotate.d/myapp
sudo logrotate -f /etc/logrotate.d/myapp
```

Wrapper:

```bash
sudo ./scripts/custom_rotate.sh /etc/logrotate.d/myapp /var/lib/logrotate/myapp.status
```

## Test

```bash
./tests/test_logrotation.sh
```
