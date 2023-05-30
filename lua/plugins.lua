return {
   {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                integrations = {
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = true,
                    }
                }
            })
            vim.cmd([[colorscheme catppuccin]])
        end,
   },
   {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = {
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      },
    },
    {
      "echasnovski/mini.comment", -- gc, comment selection, gcc comment line
      version = '*',
      config = true
    },
    { "MunifTanjim/nui.nvim", lazy = true },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {'nvim-lua/plenary.nvim'},
      commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
      cmd = "Telescope",
      version = false, -- telescope did only one release, so use HEAD for now
      keys = {
        { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
        -- find
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
        -- search
        { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>ss","<cmd>Telescope lsp_references<cr>",desc = "Goto Symbol"},
      },
      opts = {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
              end,
              ["<a-t>"] = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(...)
              end,
              ["<a-i>"] = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                Util.telescope("find_files", { no_ignore = true, default_text = line })()
              end,
              ["<a-h>"] = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                Util.telescope("find_files", { hidden = true, default_text = line })()
              end,
              ["<C-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<C-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-f>"] = function(...)
                return require("telescope.actions").preview_scrolling_down(...)
              end,
              ["<C-b>"] = function(...)
                return require("telescope.actions").preview_scrolling_up(...)
              end,
            },
            n = {
              ["q"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
        },
      },
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
       dependencies = {'kyazdani42/nvim-web-devicons'},
      cmd = "Neotree",
      keys = {
        {
          "<leader>fe",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
      },
      deactivate = function()
        vim.cmd([[Neotree close]])
      end,
      init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        if vim.fn.argc() == 1 then
          local stat = vim.loop.fs_stat(vim.fn.argv(0))
          if stat and stat.type == "directory" then
            require("neo-tree")
          end
        end
      end,
      opts = {
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = true,
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = {
            ["<space>"] = "none",
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
        },
      },
      config = function(_, opts)
        require("neo-tree").setup(opts)
        vim.api.nvim_create_autocmd("TermClose", {
          pattern = "*lazygit",
          callback = function()
            if package.loaded["neo-tree.sources.git_status"] then
              require("neo-tree.sources.git_status").refresh()
            end
          end,
        })
      end,
    },
    {
        'nvim-lualine/lualine.nvim', -- Fancier statusline
        opts = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = '|',
            section_separators = '',
            extensionts = {'neo-tree', 'lazy'}
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append "eol:↴"

            require('indent_blankline').setup {
              show_trailing_blankline_indent = false,
              char_highlight_list = {
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
                "IndentBlanklineIndent3",
                "IndentBlanklineIndent4",
                "IndentBlanklineIndent5",
                "IndentBlanklineIndent6",
              },
            }
        end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      version = false, -- last release is way too old and doesn't work on Windows
      build = ":TSUpdate",
      event = { "BufReadPost", "BufNewFile" },
      dependencies = {
        {
          "nvim-treesitter/nvim-treesitter-textobjects",
          init = function()
            -- PERF: no need to load the plugin, if we only need its queries for mini.ai
            local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local enabled = false
            if opts.textobjects then
              for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                if opts.textobjects[mod] and opts.textobjects[mod].enable then
                  enabled = true
                  break
                end
              end
            end
            if not enabled then
              require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
            end
          end,
        },
      },
      keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Decrement selection", mode = "x" },
      },
      opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "html",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      },
      config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          local added = {}
          opts.ensure_installed = vim.tbl_filter(function(lang)
            if added[lang] then
              return false
            end
            added[lang] = true
            return true
          end, opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
    {
       'akinsho/toggleterm.nvim',
        opts = {
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
    },
    {
       'jakewvincent/mkdnflow.nvim',
        ft = "markdown",
        opts = {
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
        }
    },
-- ABOVE IS THE LIVING, BELOW MORE CONFIG NEEDED
   'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
   'hrsh7th/nvim-cmp', -- Autocompletion plugin
   'hrsh7th/cmp-nvim-lsp',
   'romgrk/barbar.nvim',
   'saadparwaiz1/cmp_luasnip',
   'tversteeg/registers.nvim', -- " in normal mode or Ctrl R to open register list
   'jbyuki/venn.nvim',
   "ellisonleao/glow.nvim",
   'L3MON4D3/LuaSnip', -- Snippets plugin
   'hrsh7th/cmp-path',
   'hrsh7th/cmp-buffer',
}
