return {
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig", -- main LSP plugin
    dependencies = {
      "hrsh7th/nvim-cmp", -- Completion engine plugin
      "hrsh7th/cmp-nvim-lsp", -- Completion source suggestions feed
      "hrsh7th/cmp-buffer", -- Source that suggests words found on buffer
      "hrsh7th/cmp-path", -- A source that completes filesystem paths
      "L3MON4D3/LuaSnip", -- The snippet engin. It expands snippets
      "saadparwaiz1/cmp_luasnip", -- The bridge between LuaSnip and nvim-cmp
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },

    opts = {},
  },

  -- Rust plugin for code completion
  -- Rust: handles its own lazy-loading: codelld is autodetected from the PATH
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false,
    init = function()
      -- A function, so the requires below only run when rust-analyzer starts,
      -- not at NeoVim startup (which would force-load nvim-cmp early).
      vim.g.rustaceanvim = function()
        return {
          server = {
            capabilities = vim.tbl_deep_extend(
              "force",
              require("nvchad.configs.lspconfig").capabilities,
              require("cmp_nvim_lsp").default_capabilities()
            ),
            default_settings = {
              ["rust-analyzer"] = {
                check = { command = "clippy" },
                cargo = { allFeatures = true },
                procMacro = { enable = true },
              },
            },
          },
        }
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-tree/nvim-tree.lua",
    opts = function(_, opts)
      opts.filters = vim.tbl_deep_extend("force", opts.filters or {}, {
        dotfiles = false, -- false = do NOT hide dotfiles
        git_ignored = false, -- also show files listed in .gitignore
      })
      opts.filters.custom = {} -- NvChad hides `.git` here; remove this line to keep it hidden.
      return opts
    end,
  },

  -- Include hidden files in <leader>ff (but not the contents of .git/)
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    },
  },
}
