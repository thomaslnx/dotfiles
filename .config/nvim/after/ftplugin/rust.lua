local bufnr = vim.api.nvim_get_current_buf()

local function map(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
end

-- Expand macro recursively (cursor on a macro call, derive or attribute)
map("<leader>rm", function()
  vim.cmd.RustLsp "expandMacro"
end, "Rust: expand macro (vertical split)")
map("<leader>rM", function()
  vim.cmd.RustLsp { "expandMacro", "float" }
end, "Rust: expand macro (float)")

-- Useful alongside it, especially when editing a proc macro yourself
map("<leader>rP", function()
  vim.cmd.RustLsp "rebuildProcMacros"
end, "Rust: rebuild proc macros")
map("<leader>rd", function()
  vim.cmd.RustLsp "debuggables"
end, "Rust: debuggables")
map("<leader>rr", function()
  vim.cmd.RustLsp "runnables"
end, "Rust: runnables")
map("<leader>ra", function()
  vim.cmd.RustLsp "codeAction"
end, "Rust: code action (grouped)")
