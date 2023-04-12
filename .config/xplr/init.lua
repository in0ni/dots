version = '0.21.0'

local home = os.getenv("HOME")

package.path = os.getenv("XDG_CONFIG_HOME") .. "/xplr/?/init.lua"
require('files').setup()

xplr.config.general.focus_ui.style.fg = { Rgb = {231, 97, 11} }

-- key bindings
key = xplr.config.modes.builtin.default.key_bindings.on_key
key.m = {
  help = "xpm",
  messages = {
    "PopMode",
    { SwitchModeCustom = "xpm" },
  },
}

key.R = {
  help = "batch rename",
  messages = {
    {
      BashExec = [===[
       renamer
       "$XPLR" -m ExplorePwdAsync
     ]===],
     --  BashExec = [===[
     --   SELECTION=$(cat "${XPLR_PIPE_SELECTION_OUT:?}")
     --   NODES=${SELECTION:-$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}")}
     --   if [ "$NODES" ]; then
     --     echo -e "$NODES" | renamer
     --     "$XPLR" -m ExplorePwdAsync
     --   fi
     -- ]===],
    },
  },
}

-- ideally these would be replaced by handle_node
key.e = xplr.config.modes.builtin.action.key_bindings.on_key.e

key["enter"] = {
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
          xdg-open "${XPLR_FOCUS_PATH:?}"
        ]===],
      }
    }
  end 
end

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

-- Let xpm manage itself
require("xpm").setup({
  plugins = {
    'dtomvan/xpm.xplr',
    'sayanarijit/fzf.xplr',
    'sayanarijit/wl-clipboard.xplr',
    'sayanarijit/trash-cli.xplr',
    'igorepst/context-switch.xplr',
    'sayanarijit/type-to-nav.xplr',
  },
  auto_cleanup = true,
})

-- vim: ft=lua
