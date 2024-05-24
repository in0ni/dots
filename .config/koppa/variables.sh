#!/usr/bin/env bash
# THEME
#
theme=Arc-Dark
theme_icon=Tela-circle-orange-dark
theme_icon_variant=Tela-circle-orange
theme_cursor=Adwaita
theme_cursor_size=0

#
# FONTS
#
font_sans="Open Sans"
font_mono="Fira Code"
font_icon="Font Awesome 6 Free"
font_size=15
font_size_sm=12
font_size_xs=9
hintstyle=hintnone
rgba=rgb

# transparency
trnz_10=e5
trnz_15=d9
trnz_20=cc
trnz_50=80
trnz_70=b2
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
theme_light_1=d3dae3
theme_light_2=bac3cf
theme_light_3=afb8c6
theme_light_4=8a919e

# highlight for menus
# theme_highlight=06a284
theme_highlight=e7610b

# https://github.com/morhetz/gruvbox
# [monochrome]
gruv_dark_bg_0_h=1d2021
gruv_dark_bg_0_s=32302f
gruv_dark_bg_0=282828
gruv_dark_bg_1=3c3836
gruv_dark_bg_2=504945
gruv_dark_bg_3=665c54
gruv_dark_bg_4=7c6f64
gruv_dark_gray_mute=ebdbb2 #gruv_light_bg_1
gruv_gray=928374
gruv_light_bg_0_h=f9f5d7
gruv_light_bg_0_s=f2e5bc
gruv_light_bg_0=fbf1c7
gruv_light_bg_1=ebdbb2
gruv_light_bg_2=d5c4a1
gruv_light_bg_3=bdae93
gruv_light_bg_4=a89984
gruv_light_gray_mute=3c3836 # dark_bg_1

# [dark:colors]
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

# [light:clors]
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
gruv_light_orange=e7610b
# gruv_light_orange=d65d0e
gruv_light_orange_mute=af3a03

# base 16 colors -- gruv-based, but not...
b16_00_black=$gruv_dark_bg_0_h
b16_01_red=ff0077
b16_02_green=02d200
b16_03_yellow=ffe800
b16_04_blue=14a4ff
b16_05_purple=f459d0
b16_06_aqua=00d1bb
b16_07_white=$gruv_light_bg_0_h
b16_08_black=$gruv_gray
b16_09_red=ff5764
b16_10_green=ade525
b16_11_yellow=f7fe2c
b16_12_blue=4acdf8
b16_13_purple=f479f6
b16_14_aqua=06f6c9
b16_15_white=ebfdff

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
gruv_dark_0_rgb=$(hex_to_rgb $gruv_dark_bg_0)
gruv_dark_1_rgb=$(hex_to_rgb $gruv_dark_bg_1)
gruv_dark_3_rgb=$(hex_to_rgb $gruv_dark_bg_3)
gruv_dark_4_rgb=$(hex_to_rgb $gruv_dark_bg_4)
gruv_light_0_rgb=$(hex_to_rgb $gruv_light_bg_0)
gruv_light_0_h_rgb=$(hex_to_rgb $gruv_light_bg_0_h)
gruv_light_1_rgb=$(hex_to_rgb $gruv_light_bg_1)
gruv_light_2_rgb=$(hex_to_rgb $gruv_light_bg_2)
gruv_light_3_rgb=$(hex_to_rgb $gruv_light_bg_3)
gruv_light_4_rgb=$(hex_to_rgb $gruv_light_bg_4)
