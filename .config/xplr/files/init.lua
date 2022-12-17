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
  -- node_types.mime_essence = {
  --   text = {
  --     ["*"] = { style = { fg = "Yellow" } },
  --   },
  -- }

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

  -- binary
  exts = {
    "cbr",
    "cbz",
    "chm",
    "djvu",
    "pdf",
    "mobi",
    "epub",
  }
  for x = 1, #(exts) do
    ext[exts[x]] = {
      meta = { icon = "" },
      style = { fg = "Cyan" },
    }
  end
  ext.pdf.meta = { icon ="" }

  -- words
  exts = {
    "odb",
    "odt",
    "pages",
    "doc",
    "docm",
    "docx",
    "rtf",
  }
  for x = 1, #(exts) do
    ext[exts[x]] = {
      style = { fg = "LightBlue" },
    }
  end
  ext.rtf.style.sub_modifiers = { "Bold" }

  icon_exts = {
    "odb",
    "odt",
    "pages",
    "doc",
    "docm",
    "docx",
  }
  for x = 1, #(icon_exts) do
    ext[icon_exts[x]].meta = { icon ="" }
  end

  -- presentation
  exts = {
    "odp",
    "key",
    "pps",
    "ppt",
    "pptx",
    "ppts",
    "pptxm",
    "pptm",
    "pptsm",
  }
  for x = 1, #(exts) do
    ext[exts[x]] = {
      meta = { icon = "" },
      style = { fg = "LightYellow" },
    }
  end

  -- spreadsheet
  exts = {
    "csv",
    "tsv",
    "ods",
    "numbers",
    "xla",
    "xls",
    "xlsx",
    "xlsxm",
    "xltm",
    "xltx",
  }
  for x = 1, #(exts) do
    ext[exts[x]] = {
      meta = { icon = "" },
      style = { fg = "Green" },
    }
  end
  ext.csv.meta.icon = ""
  ext.csv.style.sub_modifiers = { "Italic" }

  -- -- binary
  -- exts = {
  -- }
  -- for x = 1, #(exts) do
  --   ext[exts[x]] = {
  --     style = { fg = "Cyan", add_modifiers = { "Bold" } },
  --   }
  -- end

end

return { setup = setup }
