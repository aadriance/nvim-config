--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--Add leader shortcuts
-- Diagnostic keymaps
--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Copy to clipboard in normal, visual, select and operator modes
vim.keymap.set('v', '<leader>c', '"+y')

-- Clear highlights
vim.keymap.set('n', '<C-c>', '<Cmd>noh<CR>')

-- sane split moves
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

-- sane terminal exit
vim.keymap.set('t', '<C-x>', '<C-\\><C-n>')

-- Toggle file explorer
vim.keymap.set('n', '<leader>se', '<cmd>NvimTreeToggle<CR>')   

-- Move to previous/next
vim.keymap.set('n', '<A-,>', ':BufferPrevious<CR>')
vim.keymap.set('n', '<A-.>', ':BufferNext<CR>')
-- Re-order to previous/next
vim.keymap.set('n', '<A-<>', ':BufferMovePrevious<CR>')
vim.keymap.set('n', '<A->>', ' :BufferMoveNext<CR>')
-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', ':BufferGoto 1<CR>')
vim.keymap.set('n', '<A-2>', ':BufferGoto 2<CR>')
vim.keymap.set('n', '<A-3>', ':BufferGoto 3<CR>')
vim.keymap.set('n', '<A-4>', ':BufferGoto 4<CR>')
vim.keymap.set('n', '<A-5>', ':BufferGoto 5<CR>')
vim.keymap.set('n', '<A-6>', ':BufferGoto 6<CR>')
vim.keymap.set('n', '<A-7>', ':BufferGoto 7<CR>')
vim.keymap.set('n', '<A-8>', ':BufferGoto 8<CR>')
vim.keymap.set('n', '<A-9>', ':BufferGoto 9<CR>')
vim.keymap.set('n', '<A-0>', ':BufferLast<CR>')
-- Close buffer
vim.keymap.set('n', '<A-c>', ':BufferClose<CR>')
-- Magic buffer-picking mode
vim.keymap.set('n', '<C-p>', ':BufferPick<CR>')
-- Glow preview
vim.keymap.set('n', '<leader>md', ':Glow<CR>')

-- Custom Terminal pop-ups!
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

local pwsh = Terminal:new({ cmd = "pwsh", hidden = true })

function _pwsh_toggle()
  pwsh:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _pwsh_toggle()<CR>", {noremap = true, silent = true})

-- venn.nvim: enable or disable keymappings
-- leader-v to enable then:
--  * HJKL to draw a line
--  * v to enter visual mode, f to draw box
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
