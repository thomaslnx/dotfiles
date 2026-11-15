-- Crates.nvim for dependencies managment on Cargo.toml
return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  opts = {
    lsp = { enabled = true, actions = true, completion = true, hover = true },
  },
}
