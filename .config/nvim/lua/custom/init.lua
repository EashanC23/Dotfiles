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

vim.cmd([[
augroup NvimTreeAutoOpen
    autocmd!
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | NvimTreeToggle (argv()[0]) | endif
augroup END
]])
