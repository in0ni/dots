version = '0.21.7'

xplr.config.general.panel_ui.default.border_type = "Thick"
xplr.config.general.panel_ui.default.border_style.fg = { Rgb = {"!{gruv_dark_1--rgb}!"} }

-- main pane titles
xplr.config.general.panel_ui.table.title.style.fg = { Rgb = {"!{gruv_light_h--rgb}!"} }
xplr.config.general.panel_ui.selection.title.style.fg = { Rgb = {"!{gruv_light_h--rgb}!"} }

-- secondary pane titles
xplr.config.general.panel_ui.sort_and_filter.title.style.fg = { Rgb = {"!{gruv_light_2--rgb}!"} }
xplr.config.general.panel_ui.input_and_logs.title.style.fg = { Rgb = {"!{gruv_light_2--rgb}!"} }
xplr.config.general.panel_ui.help_menu.title.style.fg = { Rgb = {"!{gruv_light_2--rgb}!"} }

-- secondary pane content
xplr.config.general.table.header.style.fg = { Rgb = {"!{gruv_light_4--rgb}!"} }
xplr.config.general.panel_ui.sort_and_filter.style.fg = { Rgb = {"!{gruv_light_4--rgb}!"} }
xplr.config.general.panel_ui.help_menu.style.fg = { Rgb = {"!{gruv_light_4--rgb}!"} }

-- active/selected items
xplr.config.general.focus_ui.style.fg = { Rgb = {"!{shell_highlight--rgb}!"} }
xplr.config.general.selection_ui.style.fg = { Rgb = {"!{shell_highlight--rgb}!"} }

--
-- key bindings
--
key = xplr.config.modes.builtin.default.key_bindings.on_key

-- manage plugins
-- key.m = {
--   help = "xpm",
--   messages = {
--     "PopMode",
--     { SwitchModeCustom = "xpm" },
--   },
-- }

-- renamer
key.R = {
  help = "batch rename",
  messages = {
    {
      BashExec = [===[
       SELECTION=$(cat "${XPLR_PIPE_SELECTION_OUT:?}")
       NODES=${SELECTION:-$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}")}
       if [ "$NODES" ]; then
         echo -e "$NODES" | renamer
         "$XPLR" -m ExplorePwdAsync
       fi
     ]===],
    },
  },
}

-- ideally these would be replaced by handle_node
key.e = xplr.config.modes.builtin.action.key_bindings.on_key.e

key.enter = {
  help = "Open/Enter",
  messages = {
    { CallLuaSilently = "custom.handle_node" }
  }
}

xplr.fn.custom.handle_node = function(app)
  local node = app.focused_node

  if node.is_dir or (node.is_symlink and node.symlink.is_dir) then
    return {"Enter"}
  else
    return {
      {
        BashExecSilently0 = [===[
         NODES=$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}")
         if [ "$NODES" ]; then
           xdg-open "${XPLR_FOCUS_PATH:?}" &
         fi
       ]===],
        -- BashExecSilently0 = [===[
        --   xdg-open "${XPLR_FOCUS_PATH:?}" &
        -- ]===],
      }
    }
  end 
end

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path
  .. ";"
  .. xpm_path
  .. "/?.lua;"
  .. xpm_path
  .. "/?/init.lua"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)

require("xpm").setup({
  plugins = {
    'dtomvan/xpm.xplr',
    'sayanarijit/fzf.xplr',
    'sayanarijit/wl-clipboard.xplr',
    'sayanarijit/trash-cli.xplr',
    'igorepst/context-switch.xplr',
    'sayanarijit/type-to-nav.xplr',
  },
  auto_install = true,
  auto_cleanup = true,
})
