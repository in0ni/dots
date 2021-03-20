#
# THEME
#
theme=Arc-Dark
theme_icon=Tela-manjaro-dark
theme_icon_variant=Tela-manjaro

#
# FONTS
#
font_sans="IBM Plex Sans"
font_mono="IBM Plex Mono"
font_icon="Font Awesome 5 Free"
font_size=11
font_size_rofi=10.5
font_size_sm=10

# transparency
trnz_10=e5
trnz_15=d9

# typeface configuration
hintstyle=hintfull
rgba=rgb

#
# COLORS
#

#
# -> theme-based colors
theme_highlight=06a284

theme_black=22232b
theme_darkest=2f343f
theme_dark=353945
theme_mid=404552
theme_light=cfd6e6
theme_lightest=e7e8eb
theme_white=ffffff
theme_highlight=06a284

#
# -> little converter, as some (waybar/firefox) require rgb
hex_to_rgb() {
  printf "%d, %d, %d" 0x${1:0:2} 0x${1:2:2} 0x${1:4:2}
}
theme_highlight_rgb=$(hex_to_rgb $theme_highlight)
theme_black_rgb=$(hex_to_rgb $theme_black)
theme_darkest_rgb=$(hex_to_rgb $theme_darkest)
theme_dark_rgb=$(hex_to_rgb $theme_dark)
theme_mid_rgb=$(hex_to_rgb $theme_mid)
theme_light_rgb=$(hex_to_rgb $theme_light)
theme_lightest_rgb=$(hex_to_rgb $theme_lightest)
theme_white_rgb=$(hex_to_rgb $theme_white)

#
# -> terminal

# black (same as theme_black)
term_color0=22232b
term_color8=5d6574
# red
term_color1=f3077b
term_color9=fd87be
# green
# NOTE: slightly lighter version of theme_highlight
term_color2=00b895
term_color10=22e0b9
# yellow
term_color3=f6ee13
term_color11=fbf98e
# blue
term_color4=2e93ff
term_color12=8fc1ff
# magenta
term_color5=cc68d9
term_color13=e1a5e8
# cyan
term_color6=0dedd2
term_color14=87f7ea
# white
term_color7=fafafa
term_color15=f0f0f0

# extended base 16
# orange - same as gruv_light_orange (old: ff9f1c)
term_color16=d65d0e
# brown
term_color17=8a4700
# darkest gray
term_color18=262840
# dark gray
term_color19=898998
# mid gray
term_color20=c1c1c8
#light gray
term_color21=e3e3e3

#
# -> gruvbox
# NOTE: bg goes from full (0) to muted (4)
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

