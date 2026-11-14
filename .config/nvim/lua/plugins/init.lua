return {
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
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
    -- ft = {
    --   "javascript",
    --   "javascriptreact",
    --   "typescript",
    --   "typescriptreact",
    --   "html",
    -- },
    -- config = function()
    --  require("nvim-ts-autotag").setup()
    -- end,
  },

  -- Treesetter needed for the correction working of nvim-ts-autotag
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    -- event = { "BufReadPost", "BufNewFile" },

    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",

        "html",
        "css",
        "scss",

        "javascript",
        "typescript",
        "tsx",
        "jsdoc",

        "json",
        "yaml",
        "toml",

        "bash",
        "dockerfile",
        "regex",

        "markdown",
        "markdown_inline",

        "rust",
        "c",
        "cpp",
      },

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },

      -- autotag = {
      --  enable = true,
      -- },
    },
  },
  -- Rust plugin for code completion
  -- Rust: handles its own lazy-loading: codelld is autodetected from the PATH
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false,
    -- All config bellow commented to fill new config
    -- version = "^9.0.2", -- Recommended
    -- ft = "rust",
    -- init = function()
    --  local cfg = require "rustaceanvim.config"
    --  local extension_path = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/"
    --  local codelldb_path = extension_path .. "adapter/codelldb"
    --  local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

    --  if vim.fn.filereadable(codelldb_path) == 1 then
    --    vim.g.rustaceanvim = {
    --      dap = {
    --        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    --      },
    --    }
    --  else
    --    vim.g.rustaceanvim = {}
    --  end
    --end,
  },

  -- Removed, because it formatted twice alongside conform.
  -- {
  --  "rust-lang/rust.vim",
  --  ft = "rust",
  --  init = function()
  --    vim.g.rustfmt_autosave = 1
  --   end,
  -- },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },

  -- Removed, because it never loaded under defaults.lazy = true.
  -- You install codelldb once by hand (step 6 below).
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
  --   opts = {
  --     ensure_installed = { "codelldb" }, -- 👈 this auto-installs codelldb, typescript-languge-server
  --     automatic_installation = true,
  --   },
  -- },

  -- Cargo.toml: crates.nvim's built-in LSP (replaces the deprecated cmp source)
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      lsp = { enabled = true, actions = true, completion = true, hover = true },
    },
    -- ft = { "toml" },
    -- config = function()
    --   require("crates").setup {}
    --   require("cmp").setup.buffer {
    --     sources = { { name = "crates" } },
    --   }
    -- end,
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
        dotfiles = false,    -- false = do NOT hide dotfiles
        git_ignored = false  -- also show files listed in .gitignore
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
