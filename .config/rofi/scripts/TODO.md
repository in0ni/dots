# Bluetoothctl

Ordered by priority.

- [ ] **Verify scan timeout on hardware** — confirm `bluetoothctl --timeout 30 scan on`
      keeps discovering for the full 30s on bluez 5.88 and then stops on its own
      (only tested against a mock so far).
- [ ] **Cache `bluetoothctl` output per redraw** — the main menu runs `bluetoothctl show`
      5× (Powered is checked twice) and the device menu runs `info` 3× plus `devices`.
      Capture once into a variable and test with `[[ $out == *"Powered: yes"* ]]`.
- [ ] **Cleanup in `device_menu`** — `""${dev[connect]}""` + `shellcheck disable=SC2086,SC2027`
      should just be `"${dev[connect]}"`.
- [ ] **Richer main device list**
  - status glyph per device: connected / paired / discovered-only
    (`bluetoothctl devices Connected`, `devices Paired`)
  - connected first; unpaired scan results in their own section
  - battery level (`Battery Percentage` in `bluetoothctl info`, e.g. WF-1000XM5)
  - per-row icons via `\0icon\x1f<Icon:>` from `bluetoothctl info` (audio-headset, input-mouse…)
- [ ] **Refresh entry while discovering** — re-runs `show_menu` so newly found devices appear.
- [ ] **Shorter notifications** — parse `bluetoothctl` output into a single success/failure
      line instead of passing the raw (often multi-line) text.
- [ ] **Async power on** — `toggle_power` can block for seconds (rfkill unblock wait);
      detach it like connect and show a "Powering on…" pending label.
- [ ] **Audio profile entries** — for connected headsets, add "Headset / Music profile"
      rows in the device menu that call `wm-bt-profile headset|music` (Super+Z submap).
- [ ] **Stop service entry** — counterpart to "Start bluetooth service" (low value).
- [ ] **Pairing** (low priority, never needed so far)
  - run `pair` async with a "Pairing…" label, then auto `trust` + `connect`
  - ensure a scan is running first (devices must have been seen recently)
  - no agent installed: on auth failure open `kitty -e bluetoothctl` to enter/confirm
    the PIN (alt: `bt-agent` from bluez-tools as a user service)

# Iwctl

Ordered by priority.

- [ ] **Verify on real hardware** — not yet exercised end to end:
  - password connect via `common/iwd-connect` (wrong password once, then right one),
    e.g. on a phone hotspot
  - "Turn on Wi-Fi" (`iwctl device wlan0 set-property Powered off`, then Super+Y)
- [ ] **Switch listing/state to D-Bus** — `common/iwd` (written + tested, not wired in yet)
      replaces parsing iwctl's text tables (fixed `substr()` columns break on multi-byte
      SSIDs). Subcommands: `state`, `networks`, `known`, `connect`, `connect-hidden`.
      Then remove `common/iwd-connect`. Bonus: correct local "last connected" times
      (iwctl shows them an hour off, apparently UTC).
- [ ] **Hidden networks** — "Connect to hidden network..." entry → type SSID → try
      `iwd connect-hidden` without a password; exit code 3 (passphrase required) → show
      the password prompt. Open hidden networks connect directly. Same exit-3 path gives
      known networks with a changed password a prompt instead of a bare failure.
- [ ] **Cleanup**
  - top-level vars named `local_ssid` / `local_toggle` aren't local → `ssid`, `toggle`
  - drop `output=$()` + `echo -en` wrappers and `ansi_clean` once parsing is D-Bus
  - narrow the file-wide `shellcheck disable=SC2034` to the vars `common/util` consumes
  - remove unused `icons_rofi[show]`
  - escape `& < >` in SSIDs used in `set_message` (rofi messages are Pango markup)
- [ ] **Non-blocking connect** — connecting freezes rofi for seconds with no feedback;
      run detached with a "Connecting…" pending row, like bluetoothctl.
- [ ] **Multiple adapters** — only the first station device is used (fine on x12;
      matters only with a USB adapter).

# Gopass

Ordered by priority.

- [ ] **Verify on real entries** — only tested against mocks: copy an entry with a
      `username:` field (password → clipboard, username → primary, "Username cleared"
      after `core.cliptimeout`), cancel pinentry once (expect "Could not decrypt").
- [ ] **Entry names** — list uses awk `$1`, so a name with a space would be truncated
      (none of the 202 today); `echo -e` interprets backslashes in names. Use the whole
      line and `printf`.
- [ ] **Notifications** — gopass already notifies on clip/clear (`core.notifications = true`);
      decide whether the script's own notifications duplicate it.
- [ ] **OTP** — "copy OTP" for entries that have one (`gopass otp -c <entry>`).
- [ ] **Create entry from custom input** — typing a non-existent name + Enter (ROFI_RETV=2)
      does nothing; offer "Create <name> with a generated password" (`gopass generate`).
- [ ] **Generate & save** — generated passwords are copy-only and lost after the timeout;
      add a "save as..." option.

# Timezone

> Possible deletion candidate, see [Deletion candidates](#deletion-candidates).

- [ ] **Fix tz parsing** (line 40) — `tz=${ROFI_INFO#*"${cmd[copy]}":}` references an
      undefined `cmd[copy]`; only works because the empty key strips up to the first `:`.
      Should be `${cmd[change_timezone]}`.
- [ ] **Dead branch** — `cmd[list_timezones]` is never emitted by any entry, so its
      `case` branch is unreachable; remove it or add a matching entry.
- [ ] **Notify on failure** — `timedatectl set-timezone` result is ignored; pass its exit
      code to `notify` (header TODO "use notifications" is otherwise done).
- [ ] **Mark current timezone** — highlight/preselect the active zone
      (`timedatectl show -p Timezone --value`).

# IPTV

> Possible deletion candidate, see [Deletion candidates](#deletion-candidates).

- [ ] **Move playlist URL out of the script** — the M3U URL (with what looks like an
      account token) is hard-coded and ends up in the dots repo; read it from an
      untracked file (e.g. `~/.config/rofi-iptv.url`) instead.
- [ ] **Handle missing cache** — `~/.cache/rofi-iptv` doesn't exist until the first
      "Download & Sync"; `cat` errors on stderr. Show a hint entry instead.
- [ ] **Sync feedback** — sync runs silently and exits; notify on success/failure
      (wget exit code, channel count) and reopen the list.

# Deletion candidates

Not bound in Hyprland (no `rofi -show <mode>` in `~/.config/hypr`, waybar or `~/.local/bin`)
and rarely used. Decide whether to delete; move to `../scripts-bak/` rather than `rm`.

- [ ] **hdmi**
- [ ] **iptv** (see `# IPTV` above; hard-coded playlist URL/token is another reason to drop it)
- [ ] **systemd**
- [ ] **timezone** (see `# Timezone` above)
