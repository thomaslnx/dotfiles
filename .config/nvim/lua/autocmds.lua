require "nvchad.autocmds"

-- local autocmd = vim.api.nvim_create_autocmd

-- autocmd("BufWritePre", {
--   pattern = {
--     "*.js",
--     "*.jsx",
--     "*.ts",
--     "*.tsx",
--   },
--
--   callback = function(args)
--     local clients = vim.lsp.get_clients({
--       bufnr = args.buf,
--     })
--
--     for _, client in ipairs(clients) do
--       if client:supports_method("textDocument/formatting") then
--         vim.lsp.buf.format({
--           bufnr = args.buf,
--           async = false,
--         })
--
--         return
--       end
--     end
--   end,
-- })
