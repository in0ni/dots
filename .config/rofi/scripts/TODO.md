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

# Timezone

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

- [ ] **Move playlist URL out of the script** — the M3U URL (with what looks like an
      account token) is hard-coded and ends up in the dots repo; read it from an
      untracked file (e.g. `~/.config/rofi-iptv.url`) instead.
- [ ] **Handle missing cache** — `~/.cache/rofi-iptv` doesn't exist until the first
      "Download & Sync"; `cat` errors on stderr. Show a hint entry instead.
- [ ] **Sync feedback** — sync runs silently and exits; notify on success/failure
      (wget exit code, channel count) and reopen the list.
