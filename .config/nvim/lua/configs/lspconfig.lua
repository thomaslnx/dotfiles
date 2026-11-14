require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "lua_ls",
  "jsonls",
  "tailwindcss",
  "dockerls",
  "docker_compose_language_server",
  "clangd",
  "bashls",
  "eslint",
}

-- vim.lsp.config("eslint", {
--  settings = {
--    workingDirectory = { mode = "auto"},
--    format = true,
--  },
-- })

-- ESLint configuration
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    require("nvchad.configs.lspconfig").on_attach(client, bufnr)

    -- Disable ESLint formatting
    -- conform.nvim handles formatting
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  capabilities = require("nvchad.configs.lspconfig").capabilities,

  settings = {
    workingDirectory = { mode = "auto" },

    validate = "on",
    packageManager = "npm",
    format = false,
  },
})

-- Enable standar servers
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
