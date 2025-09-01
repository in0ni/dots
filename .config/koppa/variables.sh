#!/usr/bin/env bash

# shellcheck disable=SC2034

# THEME #
#

theme=Arc-Dark
theme_icon=Tela-circle-orange-dark
theme_icon_variant=Tela-circle-orange
theme_cursor=Adwaita
theme_cursor_size=0

# FONTS #
#

# used for the last few years
# font_sans="Open Sans"
# font_mono="Fira Code"

# playful options
# font_sans="Mulish"
# font_sans="Work Sans"
# font_mono="Fragment Mono"
# font_mono="Kode Mono"

font_mono="Fira Code"
font_sans="Rubik"
font_icon="Font Awesome 7 Free"
font_size=15
font_size_sm=11
# currently only used for dunst
font_size_xs=9
hintstyle=hintnone
rgba=rgb

# COLORS
#

# Two base color schemes; one only for editing (gruvbox) and one for
# everything else (windows, os, notifications, etc). editor theme
# comes in both light/dark.
#
# NOTE: theme has both light/dark, but only dark has been done
# NOTE: shades go from full (0) to muted (4)

# - transparency
a10=e5
a15=d9
a20=cc
a50=80
a70=b2
a80=33
a100=00

# window ui "shell" theme - gtk, qt-via gtk)
# cool tones, based on Arc-Dark
shell_highlight=e7610b

shell_dark=272729
shell_dark_1=33343f
shell_dark_2=373a48
shell_dark_3=454854
shell_dark_4=687183
shell_light=f1f8fd
shell_light_1=d6e0eb
shell_light_2=bac2ce
shell_light_3=adb3c2
shell_light_4=8b92a2

# https://github.com/morhetz/gruvbox
# warm tones (with matching colors)
gruv_dark_h=1d2021
gruv_dark_s=32302f
gruv_dark=282828
gruv_dark_1=3c3836
gruv_dark_2=504945
gruv_dark_3=665c54
gruv_dark_4=7c6f64

gruv_light_h=f9f5d7
gruv_light_s=f2e5bc
gruv_light=fbf1c7
gruv_light_1=ebdbb2
gruv_light_2=d5c4a1
gruv_light_3=bdae93
gruv_light_4=a89984

# gruv_dark_red=fb4934
# gruv_dark_red_mute=cc241d
# gruv_dark_green=b8bb26
# gruv_dark_green_mute=98971a
# gruv_dark_yellow=fabd2f
# gruv_dark_yellow_mute=d79921
# gruv_dark_blue=83a598
# gruv_dark_blue_mute=458588
# gruv_dark_purple=d3869b
# gruv_dark_purple_mute=b16286
# gruv_dark_aqua=8ec07c
# gruv_dark_aqua_mute=689d6a
# gruv_dark_orange=fe8019
# gruv_dark_orange_mute=d65d0e

# gruv_light_red=9d0006
# gruv_light_red_mute=cc241d
# gruv_light_green=79740e
# gruv_light_green_mute=98971a
# gruv_light_yellow=b57614
# gruv_light_yellow_mute=d79921
# gruv_light_blue=076678
# gruv_light_blue_mute=458588
# gruv_light_purple=8f3f71
# gruv_light_purple_mute=b16286
# gruv_light_aqua=427b58
# gruv_light_aqua_mute=689d6a
# gruv_light_orange=af3a03
# gruv_light_orange_mute=e7610b

# vibra16
v16_fg=f7fffe
v16_bg=1a1817
v16_accent=e7610b
v16_00_black=090b0a  # 30
v16_01_red=f50072    # 31
v16_02_green=3bd700  # 32
v16_03_yellow=f4da00 # 33
v16_04_blue=009cec   # 34
v16_05_purple=ed59e1 # 35
v16_06_aqua=00d1d9   # 36
v16_07_white=fff1cf  # 37
v16_08_black=8b8170  # 38;5;8
# v16_08_black=7c7364  # 38;5;8
v16_09_red=f8636d    # 38;5;9
v16_10_green=86d04b  # 38;5;10
v16_11_yellow=feff65 # 38;5;11
v16_12_blue=73dfff   # 38;5;12
v16_13_purple=aaa6ff # 38;5;13
v16_14_orange=ff9d4a # 38;5;14
v16_15_white=c6e2ff  # 38;5;15
