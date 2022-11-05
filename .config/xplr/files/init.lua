local function setup()
  node_types = xplr.config.node_types
  ext = node_types.extension

  -- basic types
  node_types.directory.meta.icon = ""
  node_types.directory.style.fg = "Blue"
  node_types.directory.style.sub_modifiers = { "Bold" }
  node_types.file.meta.icon = nil
  node_types.symlink.style.sub_modifiers = { "Italic" }

  --
  -- MIME
  --
  node_types.mime_essence = {
    text = {
      ["*"] = { style = { fg = "Yellow" } },
    },
    application = {
      pdf = { meta = { icon = "" }, style = { fg = "Cyan", add_modifiers = { "Bold" } } },
    },
  }

  --
  -- DOCUMENTS
  --

  -- plain-text
  ext["txt"] = { style = { fg = "Gray" } }

  -- key-value, non-relational data
  exts = {
    "bib",
    "json",
    "jsonl",
    "jsonnet",
    "libsonnet",
    "ndjson",
    "msg",
    "pgn",
    "rss",
    "xml",
    "fxml",
    "toml",
    "yaml",
    "yml",
    "RData",
    "rdata",
    "xsd",
    "dtd",
    "sgml",
    "rng",
    "rnc",
  }
  for x = 1, #(exts) do
    ext[exts[x]] = {
      style = { fg = "Yellow", add_modifiers = { "Italic" } },
    }
  end
  ext.md = { meta = { icon =" " } }
end

return { setup = setup }
