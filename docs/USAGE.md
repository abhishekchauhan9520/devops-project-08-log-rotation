# Usage Notes

`logrotate` is commonly scheduled by the host's existing systemd timer or cron integration. This project intentionally does not add a second scheduler, avoiding duplicate rotations.

Before production use, review log ownership, permissions, retention requirements, and whether `copytruncate` is appropriate. Reopening logs through the application is preferable when the application supports it.
