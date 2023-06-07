-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--80 cols of code is enough for anyone!
vim.opt.colorcolumn = "80"

--Keep cursor centerish, but don't move for small adjustments
vim.o.scrolloff = 10

-- spelling
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
