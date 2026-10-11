-- Hyprland config (Lua). Migrated from hyprland.conf (hyprlang).
-- hyprlang is deprecated since Hyprland 0.55; see https://wiki.hypr.land/Configuring/Basics/Variables/

-- Load systemd configuration
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

hl.env("XCURSOR_SIZE", "24")


------------------
---- MONITORS ----
------------------

hl.monitor({ output = "",      mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1.5 })
hl.monitor({ output = "desc:XXX Beyond TV 0x00010000",          mode = "preferred", position = "auto", scale = 1.6 })
hl.monitor({ output = "desc:MS Telematica MStar Demo 0x00000001", mode = "preferred", position = "auto", scale = 2 })


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        layout   = "dwindle",
        gaps_in  = 0,
        gaps_out = 0,

        resize_on_border = true,

        col = {
            -- TODO: use koppa
            active_border = {
                colors = { "rgba(17a3dbee)", "rgba(e3e70bee)", "rgba(e7610bee)" },
                angle  = 45,
            },
            inactive_border = {
                colors = { "rgba(353945aa)", "rgba(000000aa)" },
                angle  = 45,
            },
        },
    },

    decoration = {
        dim_inactive     = true,
        dim_strength     = 0.1,
        inactive_opacity = 0.965,

        blur = {
            enabled = false,
        },

        shadow = {
            enabled = false,
        },
    },

    input = {
        kb_layout      = "us",
        kb_variant     = "altgr-intl",
        natural_scroll = true,
        follow_mouse   = 2,
        float_switch_override_focus = false,

        touchpad = {
            natural_scroll = true,
        },
    },

    cursor = {
        no_warps         = true,
        inactive_timeout = 10,
    },

    group = {
        groupbar = {
            -- TODO: use koppa
            font_family         = "Open Sans SemiBold",
            gradients           = true,
            font_size           = 12,
            height              = 16,
            text_color          = "rgb(fff1cf)",
            text_color_inactive = "rgb(cccccc)",
            col = {
                active   = { colors = { "rgba(0,0,0,0.8)", "rgba(0,0,0,0.8)" }, angle = 0 },
                inactive = { colors = { "rgba(0,0,0,0.5)", "rgba(0,0,0,0.5)" }, angle = 0 },
            },
            gaps_in  = 2,
            gaps_out = 1,
        },
    },

    dwindle = {
        force_split    = 2,
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo     = true,
        mouse_move_focuses_monitor = false,
        mouse_move_enables_dpms   = true,
        key_press_enables_dpms    = true,
    },
})


------------------
--- ANIMATIONS ---
------------------

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 3, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 3, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 3, bezier = "default" })


---------------
--- SOURCED ---
---------------

require("binds")
require("wm")
require("gsettings")
