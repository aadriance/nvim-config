--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

--Tabs are not welcome here
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

--80 cols of code is enough for anyone!
vim.opt.colorcolumn="80"

--Show trailing spaces
vim.o.list = true

--Keep cursor centerish, but don't move for small adjustments
vim.o.scrolloff = 10

--Prefered splitting semantics
vim.o.splitright = true
vim.o.splitbelow = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme catppuccin]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- Enable background buffers. Needed to toggle term
vim.o.hidden = true
