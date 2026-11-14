local nvchad_lsp = require "nvchad.configs.lspconfig"
nvchad_lsp.defaults()

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

-- Capabilities: NvChad's defaults + nvim-cmp's, applied to every server
local capabilities =
  vim.tbl_deep_extend("force", nvchad_lsp.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- vim.lsp.config("eslint", {
--  settings = {
--    workingDirectory = { mode = "auto"},
--    format = true,
--  },
-- })

-- ESLint configuration
vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    nvchad_lsp.on_attach(client, bufnr)
    -- require("nvchad.configs.lspconfig").on_attach(client, bufnr) -- Early configuration

    -- Disable ESLint formatting
    -- conform.nvim handles formatting
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  -- capabilities = require("nvchad.configs.lspconfig").capabilities, -- Early configuration

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

-- LSP keymaps (set when a server attaches to a buffer)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump { count = -1, float = true }
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump { count = 1, float = true }
    end, opts)

    -- Inlay hints (rust-analyzer, etc), only if the server supports them
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/inlayHint", args.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

-- Autocompletion
local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
}
