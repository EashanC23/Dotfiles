-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--

vim.opt.relativenumber = true

-- Autocommand to open nvim-tree if Neovim is started with a directory
--
-- Auto-open Neo-tree when opening a file, with a delay to ensure Neo-tree is loaded
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local isEmptyBuffer = vim.fn.empty(vim.fn.expand("%:t")) == 1
--     if not isEmptyBuffer then
--       vim.defer_fn(function()
--         vim.cmd("")
--       end, 100)  -- Delay by 100ms to ensure Neo-tree is available
--     end
--   end,
--   desc = "Open Neo-tree automatically on file open",
-- })
