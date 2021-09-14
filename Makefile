#
# generates dot files using shared variables for consistent appearance
#
# takes a template file, like '_config', and replaces %{{var}} with matching
# set environment variable (dotvars.sh) in final parsed file 'config'.
#
# TODO: should warn on output when variables are not found and not build.
#
# NOTE: filename templates are preceded with an underscore '_FILENAME'
#		for each build target FILES indicates the tamplate
# 		example: _config -> config

# required for imported shell variables
.ONESHELL:

CONF_DIR = $(HOME)/.config
VARS = $(CONF_DIR)/dotvars.sh

# NOTE: blank line before endef is required
define parse_file
  echo ">> $(1)/$(2)"
  perl -p -e 's/%\{\{(\w+)\}\}/(exists $$ENV{$$1}?$$ENV{$$1}:"!!->$$1")/eg' \
  < $(1)/$(2) > $(1)/$(subst _,,$(2))
  
endef

all:
	@echo "invoque with build_CONF"

# set -a: set created var with export attribute (export var=val)
# set +a: unsets '-a'
parse_%:
	@echo "$@: start"
	@set -a
	@. $(VARS)
	@set +a
	@$(foreach FILE,$(FILES),$(call parse_file,$(DIR),$(FILE)))
	@$(if $(SERVICE),systemctl --user restart $(SERVICE))
	@echo "$@: done"

build_dunst: DIR = $(CONF_DIR)/dunst
build_dunst: FILES = _dunstrc
build_dunst: parse_dunst

build_firefox: DIR = $(CONF_DIR)/firefox
build_firefox: FILES = _manifest.json
build_firefox: parse_firefox

build_gtk-3.0: DIR = $(CONF_DIR)/gtk-3.0
build_gtk-3.0: FILES = _settings.ini _gtk.css
build_gtk-3.0: parse_gtk-3.0

build_kitty: DIR = $(CONF_DIR)/kitty
build_kitty: FILES = _theme.conf
build_kitty: parse_kitty

build_kak: DIR = $(CONF_DIR)/kak
build_kak: FILES = colors/_gruv-term.kak
build_kak: parse_kak

build_mpv: DIR = $(CONF_DIR)/mpv
build_mpv: FILES = _mpv.conf
build_mpv: parse_mpv

build_rofi: DIR = $(CONF_DIR)/rofi
build_rofi: FILES = _config.rasi \
	theme/_default.rasi theme/_gruv-dark-hard.rasi theme/_gruv-light-hard.rasi
build_rofi: parse_rofi

build_sway: DIR = $(CONF_DIR)/sway
build_sway: FILES = _windows.conf
build_sway: parse_sway

build_swaylock: DIR = $(CONF_DIR)/swaylock
build_swaylock: FILES = _config
build_swaylock: parse_swaylock

build_waybar: DIR = $(CONF_DIR)/waybar
build_waybar: FILES = _style.css
build_waybar: SERVICE = waybar.service
build_waybar: parse_waybar

build_xsettingsd: DIR = $(HOME)
build_xsettingsd: FILES = ._xsettingsd
build_xsettingsd: parse_xsettingsd

build_zim: DIR = $(CONF_DIR)/zim
build_zim: FILES = _style.conf
build_zim: parse_zim

