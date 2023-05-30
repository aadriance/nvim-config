--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    component_separators = '|',
    section_separators = '',
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

--require'nvim-tree'.setup {
  --actions = {
    --open_file = {
      --quit_on_open = true,
    --}
  --},
--}
vim.g.nvim_tree_quit_on_open = 1

-- Toggle Term
require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
}

-- Some extra markdown goodness.
require('mkdnflow').setup({
    perspective = {
        priority = 'current',
        fallback = 'first',
        root_tell = false
    },
    mappings = {
        MkdnNextLink = {'n', '<Tab>'},
        MkdnPrevLink = {'n', '<S-Tab>'},
        MkdnNextHeading = {'n', '<leader>]'},
        MkdnPrevHeading = {'n', '<leader>['},
        MkdnGoBack = {'n', '<BS>'},
        MkdnGoForward = {'n', '<Del>'},
        MkdnFollowLink = {{'n', 'v'}, '<CR>'},
        MkdnDestroyLink = {'n', '<M-CR>'},
        MkdnYankAnchorLink = {'n', 'ya'},
        MkdnYankFileAnchorLink = {'n', 'yfa'},
        MkdnIncreaseHeading = {'n', '+'},
        MkdnDecreaseHeading = {'n', '-'},
        MkdnToggleToDo = {'n', 'zz'},
        MkdnNewListItem = false
    }
})

