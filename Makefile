#
# generates dot files using shared variables for consistent appearance
#
# takes a template file, like '_config', and replaces %{{var}} with matching
# set environment variable (dotvars.sh) in final parsed file 'config'.
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
	@echo "$@: done"

build_mako: DIR = $(CONF_DIR)/mako
build_mako: FILES = _config
build_mako: parse_mako

build_gtk-3.0: DIR = $(CONF_DIR)/gtk-3.0
build_gtk-3.0: FILES = _settings.ini
build_gtk-3.0: parse_gtk-3.0

build_kitty: DIR = $(CONF_DIR)/kitty
build_kitty: FILES = _theme.conf
build_kitty: parse_kitty

build_rofi: DIR = $(CONF_DIR)/rofi
build_rofi: FILES = _config.rasi theme/_current-theme.rasi\
                    theme/_gruv-dark-hard.rasi theme/_gruv-light-hard.rasi\
                    theme/_gopass.rasi theme/_bluetooth.rasi
                    
build_rofi: parse_rofi

build_sway: DIR = $(CONF_DIR)/sway
build_sway: FILES = _windows.conf
build_sway: parse_sway

build_swaylock: DIR = $(CONF_DIR)/swaylock
build_swaylock: FILES = _config
build_swaylock: parse_swaylock

build_waybar: DIR = $(CONF_DIR)/waybar
build_waybar: FILES = _style.css
build_waybar: parse_waybar

