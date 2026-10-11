-- Keybindings. Migrated from binds.conf (hyprlang).
-- bind  -> hl.bind(keys, dispatcher)
-- binde -> { repeating = true }
-- bindl -> { locked = true }
-- bindm -> { mouse = true }

local REPEAT        = { repeating = true }
local LOCKED        = { locked = true }
local LOCKED_REPEAT = { locked = true, repeating = true }
local MOUSE         = { mouse = true }

-- Basics
hl.bind("SUPER + space",  hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + c",      hl.dsp.exec_cmd("gsimplecal"))
hl.bind("SUPER + SHIFT + z",
    hl.dsp.exec_cmd("pidof hyprlock || hyprlock & systemctl --user start idle-lock.service"))

-- Session
hl.bind("SUPER + s",       hl.dsp.exec_cmd("rofi -show session"))
hl.bind("XF86PowerOff",    hl.dsp.exec_cmd("rofi -show session"))
hl.bind("XF86PowerDown",   hl.dsp.exec_cmd("rofi -show session"))
hl.bind("XF86Sleep",       hl.dsp.exec_cmd("rofi -show session"))

-- Launchers
-- hl.bind("SUPER + a", hl.dsp.exec_cmd("rofi -show control-panel"))
hl.bind("SUPER + b", hl.dsp.exec_cmd("rofi -show bluetoothctl"))
hl.bind("SUPER + i", hl.dsp.exec_cmd("rofi -show hxi"))
hl.bind("SUPER + m", hl.dsp.exec_cmd('rofi -show emoji -modes emoji -display-emoji "💩🙊🤖👌🏼"'))
hl.bind("SUPER + p", hl.dsp.exec_cmd("rofi -show gopass"))
hl.bind("SUPER + u", hl.dsp.exec_cmd("rofi -show udiskie"))
hl.bind("SUPER + y", hl.dsp.exec_cmd("rofi -show iwctl"))

-- 'entertainment' launcher
hl.bind("XF86HomePage", hl.dsp.exec_cmd("rofi -show mediacenter"))

-- Brightness control
hl.bind("XF86MonBrightnessUp",           hl.dsp.exec_cmd("wm-brightness-ctrl up 5"),   REPEAT)
hl.bind("XF86MonBrightnessDown",         hl.dsp.exec_cmd("wm-brightness-ctrl down 5"), REPEAT)
hl.bind("SHIFT + XF86MonBrightnessUp",   hl.dsp.exec_cmd("wm-brightness-ctrl up 1"),   REPEAT)
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("wm-brightness-ctrl down 1"), REPEAT)

-- Audio
hl.bind("XF86AudioMute",              hl.dsp.exec_cmd("wm-volume-ctrl toggle"),     LOCKED)
hl.bind("XF86AudioMicMute",           hl.dsp.exec_cmd("wm-volume-ctrl mic-toggle"), LOCKED)
hl.bind("XF86AudioRaiseVolume",       hl.dsp.exec_cmd("wm-volume-ctrl up 5"),       LOCKED_REPEAT)
hl.bind("XF86AudioLowerVolume",       hl.dsp.exec_cmd("wm-volume-ctrl down 5"),     LOCKED_REPEAT)
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wm-volume-ctrl up 2"),     LOCKED_REPEAT)
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wm-volume-ctrl down 2"),   LOCKED_REPEAT)

-- Media control
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl --player playerctld play-pause"), LOCKED)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl --player playerctld next"),       LOCKED)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl --player playerctld previous"),   LOCKED)
-- was code:61 / code:60 / code:59 -- the Lua bind parser accepts code:NN but does not
-- store the keycode, so these use the equivalent keysyms (X11 59/60/61 = , . /).
hl.bind("SUPER + ALT + slash",  hl.dsp.exec_cmd("playerctl --player playerctld play-pause"), LOCKED)
hl.bind("SUPER + ALT + period", hl.dsp.exec_cmd("playerctl --player playerctld next"),       LOCKED)
hl.bind("SUPER + ALT + comma",  hl.dsp.exec_cmd("playerctl --player playerctld previous"),   LOCKED)

-- Screen capture
hl.bind("print",                hl.dsp.exec_cmd("wm-screen-capture monitor"))
hl.bind("SHIFT + print",        hl.dsp.exec_cmd("wm-screen-capture window"))
hl.bind("CTRL + SHIFT + print", hl.dsp.exec_cmd("wm-screen-capture area"))
hl.bind("CTRL + print",         hl.dsp.exec_cmd("wm-screen-record"))

-- Submaps
local submapResize     = "\u{f31e} - resize"      --  - resize
local submapBrightness = "\u{f185} - brightnes"   --  - brightnes

hl.define_submap(submapResize, function()
    hl.bind("h",         hl.dsp.window.resize({ x = -15, y = 0, relative = true }), REPEAT)
    hl.bind("l",         hl.dsp.window.resize({ x = 15, y = 0, relative = true }), REPEAT)
    hl.bind("k",         hl.dsp.window.resize({ x = 0, y = -15, relative = true }), REPEAT)
    hl.bind("j",         hl.dsp.window.resize({ x = 0, y = 15, relative = true }), REPEAT)
    hl.bind("SHIFT + h", hl.dsp.window.resize({ x = -5, y = 0, relative = true }), REPEAT)
    hl.bind("SHIFT + l", hl.dsp.window.resize({ x = 5, y = 0, relative = true }), REPEAT)
    hl.bind("SHIFT + k", hl.dsp.window.resize({ x = 0, y = -5, relative = true }), REPEAT)
    hl.bind("SHIFT + j", hl.dsp.window.resize({ x = 0, y = 5, relative = true }), REPEAT)

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("return", hl.dsp.submap("reset"))
end)

hl.define_submap(submapBrightness, function()
    hl.bind("k",         hl.dsp.exec_cmd("wm-brightness-ctrl up 5"),   REPEAT)
    hl.bind("j",         hl.dsp.exec_cmd("wm-brightness-ctrl down 5"), REPEAT)
    hl.bind("SHIFT + k", hl.dsp.exec_cmd("wm-brightness-ctrl up 1"),   REPEAT)
    hl.bind("SHIFT + j", hl.dsp.exec_cmd("wm-brightness-ctrl down 1"), REPEAT)

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("return", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + r", hl.dsp.submap(submapResize))
hl.bind("SUPER + t", hl.dsp.submap(submapBrightness))

-- Window Manager
hl.bind("ALT + SHIFT + tab",   hl.dsp.exec_cmd("rofi -show window"))
hl.bind("ALT + tab",           hl.dsp.focus({ last = true }))
hl.bind("SUPER + f",           hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + p",   hl.dsp.window.pin())
hl.bind("SUPER + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + e",           hl.dsp.layout("togglesplit"))
hl.bind("SUPER + q",           hl.dsp.window.close())

-- Groups
hl.bind("SUPER + w",         hl.dsp.group.toggle())
hl.bind("SUPER + SHIFT + g", hl.dsp.window.move({ out_of_group = true }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "right", into_or_create_group = true }))
hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "left",  into_or_create_group = true }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "up",    into_or_create_group = true }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "down",  into_or_create_group = true }))
hl.bind("SUPER + TAB",         hl.dsp.group.next())
hl.bind("SUPER + SHIFT + TAB", hl.dsp.group.prev())

-- Move focus to window in direction
hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))

-- Move focus to monitor
hl.bind("SUPER + CTRL + h", hl.dsp.focus({ monitor = "l" }))
hl.bind("SUPER + CTRL + l", hl.dsp.focus({ monitor = "r" }))
hl.bind("SUPER + CTRL + k", hl.dsp.focus({ monitor = "u" }))
hl.bind("SUPER + CTRL + j", hl.dsp.focus({ monitor = "d" }))

-- Move window with Super + SHIFT + hjkl
-- NOTE: these four keys are already bound above (moveintogroup); kept as in binds.conf.
hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Move window to monitor
hl.bind("SUPER + ALT + h", hl.dsp.window.move({ monitor = "l" }))
hl.bind("SUPER + ALT + l", hl.dsp.window.move({ monitor = "r" }))
hl.bind("SUPER + ALT + k", hl.dsp.window.move({ monitor = "u" }))
hl.bind("SUPER + ALT + j", hl.dsp.window.move({ monitor = "d" }))

-- Switch workspaces with Super + [0-9]
-- Move active window to a workspace with Super + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i, silent = true }))
end

-- Scroll through existing workspaces with Super + scroll
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with Super + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   MOUSE)
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), MOUSE)
