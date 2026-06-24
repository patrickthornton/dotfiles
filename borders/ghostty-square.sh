#!/bin/sh
# Global jankyborders style is round (set in aerospace after-startup-command).
# Ghostty is the exception: square borders.
#
# jankyborders overrides (apply-to=<window-id>) are per-window and only stick to
# windows it is currently tracking, so a newly opened window starts at the global
# (round) style. This script re-stamps every Ghostty window as square. It is
# idempotent, so it is safe to call from multiple AeroSpace callbacks.

sleep 0.2  # let jankyborders register any just-created window before we stamp it

aerospace list-windows --all --format '%{window-id}|%{app-name}' |
while IFS='|' read -r wid app; do
  [ "$app" = "Ghostty" ] && borders apply-to="$wid" style=square
done

exit 0  # the while loop's last `read` exits non-zero at EOF; report success
