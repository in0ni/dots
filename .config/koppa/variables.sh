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
font_icon="Font Awesome 6 Free"
font_size=15
font_size_sm=12
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

gruv_dark_red=fb4934
gruv_dark_red_mute=cc241d
gruv_dark_green=b8bb26
gruv_dark_green_mute=98971a
gruv_dark_yellow=fabd2f
gruv_dark_yellow_mute=d79921
gruv_dark_blue=83a598
gruv_dark_blue_mute=458588
gruv_dark_purple=d3869b
gruv_dark_purple_mute=b16286
gruv_dark_aqua=8ec07c
gruv_dark_aqua_mute=689d6a
gruv_dark_orange=fe8019
gruv_dark_orange_mute=d65d0e

gruv_light_red=9d0006
gruv_light_red_mute=cc241d
gruv_light_green=79740e
gruv_light_green_mute=98971a
gruv_light_yellow=b57614
gruv_light_yellow_mute=d79921
gruv_light_blue=076678
gruv_light_blue_mute=458588
gruv_light_purple=8f3f71
gruv_light_purple_mute=b16286
gruv_light_aqua=427b58
gruv_light_aqua_mute=689d6a
gruv_light_orange=af3a03
gruv_light_orange_mute=e7610b

# custom base16 colors (in the works)
b16_00_black=$gruv_dark_h
b16_01_red=f50072
b16_02_green=23d222
b16_03_yellow=ffe90a
b16_04_blue=14a4ff
b16_05_purple=e95eca
b16_06_aqua=00d6c0
b16_07_white=$gruv_light_h
b16_08_black=$gruv_dark_4
b16_09_red=ff5764
b16_10_green=ade525
b16_11_yellow=f7fe2c
b16_12_blue=4acdf8
b16_13_purple=f479f6
b16_14_aqua=06f6c9
b16_15_white=$shell_light

hex_to_rgb() {
  printf "%d, %d, %d" 0x"${1:0:2}" 0x"${1:2:2}" 0x"${1:4:2}"
}

shell_highlight_rgb=$(hex_to_rgb $shell_highlight)
shell_dark_rgb=$(hex_to_rgb $shell_dark)
shell_dark_1_rgb=$(hex_to_rgb $shell_dark_1)
shell_dark_2_rgb=$(hex_to_rgb $shell_dark_2)
shell_dark_3_rgb=$(hex_to_rgb $shell_dark_3)
shell_dark_4_rgb=$(hex_to_rgb $shell_dark_4)
shell_light_rgb=$(hex_to_rgb $shell_light)
shell_light_1_rgb=$(hex_to_rgb $shell_light_1)
shell_light_2_rgb=$(hex_to_rgb $shell_light_2)
shell_light_3_rgb=$(hex_to_rgb $shell_light_3)
shell_light_4_rgb=$(hex_to_rgb $shell_light_4)
gruv_dark_rgb=$(hex_to_rgb $gruv_dark)
gruv_dark_1_rgb=$(hex_to_rgb $gruv_dark_1)
gruv_dark_3_rgb=$(hex_to_rgb $gruv_dark_3)
gruv_dark_4_rgb=$(hex_to_rgb $gruv_dark_4)
gruv_light_rgb=$(hex_to_rgb $gruv_light)
gruv_light_h_rgb=$(hex_to_rgb $gruv_light_h)
gruv_light_1_rgb=$(hex_to_rgb $gruv_light_1)
gruv_light_2_rgb=$(hex_to_rgb $gruv_light_2)
gruv_light_3_rgb=$(hex_to_rgb $gruv_light_3)
gruv_light_4_rgb=$(hex_to_rgb $gruv_light_4)
