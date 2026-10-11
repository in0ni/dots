-- gsettings. Migrated from gsettings.conf (hyprlang).
-- `exec =` in hyprlang ran on every config load; top-level hl.exec_cmd does the same.

-- gtk
hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Skeuos-Orange-Dark'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-orange-dark'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'Rubik 11'")
hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

-- hl.exec_cmd("gsettings set org.nemo.desktop show-desktop-icons false")
hl.exec_cmd("gsettings set org.cinnamon.desktop.default-applications.terminal exec kitty")
hl.exec_cmd("gsettings set org.cinnamon.desktop.default-applications.terminal exec-arg --")
