local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    css = { "prettier" },
    html = { "prettier" },

    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },

    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    sh = { "shfmt" },

    c = { "clang_format" },
    cpp = { "clang_format" },

    -- rust: intentionally unlisted, so conform falls back to rust-analyzer (rustfmt)
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback", -- replaces the deprecated `lsp_fallback = true`
  },
}

return options

-- Replaced by the code above
-- return {
--   defaults = { lazy = true },
--   install = { colorscheme = { "nvchad" } },
--
--   ui = {
--     icons = {
--       ft = "",
--       lazy = "󰂠 ",
--       loaded = "",
--       not_loaded = "",
--     },
--   },
--
--   performance = {
--     rtp = {
--       disabled_plugins = {
--         "2html_plugin",
--         "tohtml",
--         "getscript",
--         "getscriptPlugin",
--         "gzip",
--         "logipat",
--         "netrw",
--         "netrwPlugin",
--         "netrwSettings",
--         "netrwFileHandlers",
--         "matchit",
--         "tar",
--         "tarPlugin",
--         "rrhelper",
--         "spellfile_plugin",
--         "vimball",
--         "vimballPlugin",
--         "zip",
--         "zipPlugin",
--         "tutor",
--         "rplugin",
--         "syntax",
--         "synmenu",
--         "optwin",
--         "compiler",
--         "bugreport",
--         "ftplugin",
--       },
--     },
--   },
-- }
