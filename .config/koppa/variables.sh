#!/usr/bin/env bash
# THEME
#
theme=Arc-Dark
theme_icon=Tela-orange-dark
theme_icon_variant=Tela-orange
theme_cursor=Adwaita
theme_cursor_size=0

#
# FONTS
#
font_sans="IBM Plex Sans"
font_mono="IBM Plex Mono"
font_icon="Font Awesome 5 Free"
font_size=11
font_size_sm=10
hintstyle=hintslight
rgba=rgb

# transparency
trnz_10=e5
trnz_15=d9
trnz_20=cc
trnz_80=33
trnz_100=00

#
# COLORS
#
# Two base color schemes; one only for editing (gruvbox) and one for
# everything else (windows, os, notifications, etc). editor theme
# comes in both light/dark.
#
# NOTE: theme has both light/dark, but only dark has been done
# NOTE: shades go from full (0) to muted (4)

#
## Operating system colors
# based on Arc-Dark, made to contrast grubvox hard
# theme_dark_0=262731
theme_dark_0=2b2d30
theme_dark_1=2f343f
theme_dark_2=353945
theme_dark_3=404552
theme_dark_4=647386
theme_light_0=f0f3ff
theme_light_1=cfd7e7
theme_light_2=bbc2d8
theme_light_3=a5adc5
theme_light_4=8992a9

# base 16 colors
b16_00_black=$theme_dark_0
b16_01_red=ff0077
b16_02_green=02d200
b16_03_yellow=ffe800
b16_04_blue=14a4ff
b16_05_purple=f459d0
b16_06_aqua=00ffcf
b16_07_white=$theme_light_1
b16_08_black=$theme_dark_4
b16_09_red=ef2121
b16_10_green=badf00
b16_11_yellow=ffa100
b16_12_blue=37d4e7
b16_13_purple=b46be6
b16_14_aqua=00e88c
b16_15_white=$theme_light_0

# highlight for menus
theme_highlight=06a284

#
## Editor-only theme: gruvbox hard
# https://github.com/morhetz/gruvbox
gruv_dark_bg_0=282828
gruv_dark_bg_1=3c3836
gruv_dark_bg_2=504945
gruv_dark_bg_3=665c54
gruv_dark_bg_4=7c6f64
gruv_dark_gray=928374
gruv_dark_red=fb4934
gruv_dark_green=b8bb26
gruv_dark_yellow=fabd2f
gruv_dark_blue=83a598
gruv_dark_purple=d3869b
gruv_dark_aqua=8ec07c
gruv_dark_orange=fe8019

gruv_light_bg_0=f9f5d7
gruv_light_bg_1=ebdbb2
gruv_light_bg_2=d5c4a1
gruv_light_bg_3=bdae93
gruv_light_bg_4=a89984
gruv_light_gray=928374
gruv_light_red=9d0006
gruv_light_green=79740e
gruv_light_yellow=b57614
gruv_light_blue=076678
gruv_light_purple=8f3f71
gruv_light_aqua=427b58
gruv_light_orange=d65d0e

#
# waybar/firefox require rgb
hex_to_rgb() {
  printf "%d, %d, %d" 0x${1:0:2} 0x${1:2:2} 0x${1:4:2}
}
theme_highlight_rgb=$(hex_to_rgb $theme_highlight)
theme_dark_0_rgb=$(hex_to_rgb $theme_dark_0)
theme_dark_1_rgb=$(hex_to_rgb $theme_dark_1)
theme_dark_2_rgb=$(hex_to_rgb $theme_dark_2)
theme_dark_3_rgb=$(hex_to_rgb $theme_dark_3)
theme_dark_4_rgb=$(hex_to_rgb $theme_dark_4)
theme_light_0_rgb=$(hex_to_rgb $theme_light_0)
theme_light_1_rgb=$(hex_to_rgb $theme_light_1)
theme_light_2_rgb=$(hex_to_rgb $theme_light_2)
theme_light_3_rgb=$(hex_to_rgb $theme_light_3)
theme_light_4_rgb=$(hex_to_rgb $theme_light_4)