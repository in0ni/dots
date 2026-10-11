-- Workspace + window rules. Migrated from wm.conf (hyprlang).

-- bind workspace to monitor
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1" })

-- assign windows to workspaces
-- Spotify now runs as a native Wayland client, so its app_id is lowercase "spotify";
-- it was "Spotify" back when it went through XWayland. (?i) matches either.
hl.window_rule({ name = "ws-spotify",  match = { class = "(?i)^spotify$" },      workspace = 4 })
hl.window_rule({ name = "ws-slack",    match = { class = "^Slack$" },            workspace = 7 })
hl.window_rule({ name = "ws-teams",    match = { class = "^teams-for-linux$" },  workspace = 7 })
hl.window_rule({ name = "ws-obsidian", match = { class = "^obsidian$" },         workspace = 6 })

-- custom window settings
hl.window_rule({
    name  = "float-qalculate",
    match = { class = "^qalculate-gtk$" },
    float  = true,
    size   = "403 525",
    center = true,
})

hl.window_rule({
    name  = "float-gsimplecal",
    match = { class = "^gsimplecal$" },
    float = true,
    move  = "(monitor_w/2)-(window_w/2) 35",
})

hl.window_rule({ name = "float-darktable-start", match = { title = "^darktable starting$" },      float = true })
hl.window_rule({ name = "float-file-progress",   match = { title = "^File Operation Progress$" }, float = true })
hl.window_rule({ name = "float-polkit",          match = { class = "^xfce-polkit$" },             float = true })
hl.window_rule({ name = "float-gcolor3",         match = { class = "^nl.hjdskes.gcolor3$" },      float = true })
hl.window_rule({ name = "float-hamster",         match = { class = "^org.gnome.Hamster.GUI$" },   float = true })
hl.window_rule({ name = "float-vbox-manager",    match = { class = "^VirtualBox Manager$" },      float = true })
hl.window_rule({ name = "float-file-roller",     match = { class = "^file-roller$" },             float = true })
hl.window_rule({ name = "move-ristretto",        match = { class = "^ristretto$" },               move  = "43% 35" })

hl.window_rule({
    name  = "firefox-sharing-indicator",
    match = { title = "^Firefox — Sharing Indicator$" },
    float = true,
    move  = "95% 40",
})

hl.window_rule({
    name  = "teams-screenshare-indicator",
    match = {
        class = "^teams-for-linux$",
        title = "^Teams for Linux - Screen is being shared$",
    },
    float   = true,
    monitor = 0,
    move    = "1589 183",
    size    = "325 194",
})

hl.window_rule({ name = "float-showmethekey", match = { class = "^one.alynx.showmethekey$" }, float = true })

hl.window_rule({
    name  = "float-vbox-settings",
    match = {
        class = "^VirtualBox(VM)?$",
        title = "(.*) - (Settings|Preferences)$",
    },
    float = true,
})

-- show me the key
-- hl.window_rule({
--     name  = "showmethekey-overlay",
--     match = { class = "^showmethekey-gtk$" },
--     move        = "0 1090",
--     size        = "100% 110",
--     no_dim      = true,
--     pin         = true,
--     border_size = 0,       -- was: noborder
--     workspace   = 1,
-- })

-- ettal
-- TODO: conditionally load this
hl.window_rule({ name = "ws-kodi",         match = { title = "^Kodi$" },             workspace = 2 })
hl.window_rule({ name = "ws-popcorntime",  match = { title = "^PopcorTime$" },       workspace = 3 })
hl.window_rule({ name = "ws-emulationsta", match = { title = "^EmulationStation$" }, workspace = 3 })
hl.window_rule({ name = "fs-retroarch",    match = { title = "^RetroArch$" },        fullscreen = true })

hl.window_rule({ name = "fs-kodi",            match = { title = "^Kodi$" },        fullscreen = true })
hl.window_rule({ name = "float-popcorntime",  match = { title = "^PopcornTime$" }, float = true })
