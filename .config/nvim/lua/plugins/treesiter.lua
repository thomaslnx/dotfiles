-- Treesitter for advanced syntax highlighting
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- fix suggestion
  lazy = false, -- fix suggestion
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup {}
    require("nvim-treesitter").install {
      "vim",
      "lua", -- blog suggested
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
      "toml", -- blog suggested

      "bash",
      "dockerfile",
      "regex",

      "markdown",
      "markdown_inline",

      "rust", -- blog suggested
      "c",
      "cpp",

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "vim",
          "lua", -- blog suggested
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
          "toml", -- blog suggested

          "bash",
          "dockerfile",
          "regex",

          "markdown",
          "markdown_inline",

          "rust", -- blog suggested
          "c",
          "cpp",
        },
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v.lua.require'nvim-treesitter'.indentexpr()"
        end,
      }),
      -- highlighting and indent are no longer enabled through setup()
      -- highlight = { enable = true }, --
    }
  end,
}
