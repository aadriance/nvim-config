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
        require 'nvim-treesitter.install'.compilers = { "zig" }
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
    {
       'romgrk/barbar.nvim',
        lazy = false,
        keys = {
            -- Move to previous/next
            { "<A-,>", ":BufferPrevious<CR>", desc = "Previous Buffer" },
            { "<A-.>", ":BufferNext<CR>", desc = "Previous Buffer" },
            -- Re-order to previous/next
            { '<A-<>', ':BufferMovePrevious<CR>', desc = ""},
            {'<A->>', ' :BufferMoveNext<CR>', desc = ""},
            -- Goto buffer in position...
            {'<A-1>', ':BufferGoto 1<CR>', desc = ""},
            {'<A-2>', ':BufferGoto 2<CR>', desc = ""},
            {'<A-3>', ':BufferGoto 3<CR>', desc = ""},
            {'<A-4>', ':BufferGoto 4<CR>', desc = ""},
            {'<A-5>', ':BufferGoto 5<CR>', desc = ""},
            {'<A-6>', ':BufferGoto 6<CR>', desc = ""},
            {'<A-7>', ':BufferGoto 7<CR>', desc = ""},
            {'<A-8>', ':BufferGoto 8<CR>', desc = ""},
            {'<A-9>', ':BufferGoto 9<CR>', desc = ""},
            {'<A-0>', ':BufferLast<CR>', desc = ""},
            -- Close buffer
            {'<A-c>', ':BufferClose<CR>', desc = ""},
            -- Magic buffer-picking mode
            {'<C-p>', ':BufferPick<CR>', desc = ""},
        },
    },
    {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
        { "folke/neodev.nvim", opts = {} },
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
      },
      opts = {
        -- options for vim.diagnostic.config()
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
        },
        -- add any global capabilities here
        capabilities = {},
        -- Automatically format on save
        autoformat = true,
        -- Enable this to show formatters used in a notification
        -- Useful for debugging formatter issues
        format_notify = false,
        -- options for vim.lsp.buf.format
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        servers = {
          jsonls = {},
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      },
      config = function(_, opts)
        local servers = opts.servers
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities(),
          opts.capabilities or {}
        )

        local function setup(server)
          local server_opts = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
          }, servers[server] or {})

          if opts.setup[server] then
            if opts.setup[server](server, server_opts) then
              return
            end
          elseif opts.setup["*"] then
            if opts.setup["*"](server, server_opts) then
              return
            end
          end
          require("lspconfig")[server].setup(server_opts)
        end

        -- get all the servers that are available thourgh mason-lspconfig
        local have_mason, mlsp = pcall(require, "mason-lspconfig")
        local all_mslp_servers = {}
        if have_mason then
          all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
        end

        local ensure_installed = {}
        for server, server_opts in pairs(servers) do
          if server_opts then
            server_opts = server_opts == true and {} or server_opts
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end

        if have_mason then
          mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
        end
      end,
    },
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
      opts = {
        ensure_installed = {
          "stylua",
          "shfmt",
          "rust-analyzer",
        },
      },
      config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        local function ensure_installed()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end
        if mr.refresh then
          mr.refresh(ensure_installed)
        else
          ensure_installed()
        end
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      version = false, -- last release is way too old
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "f3fora/cmp-spell",
      },
      opts = function()
        local cmp = require("cmp")
        return {
          completion = {
            completeopt = "menu,menuone,noinsert",
          },
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<S-CR>"] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            {
              name = 'buffer',
              option = {
                get_bufnrs = function()
                  return vim.api.nvim_list_bufs()
                end
              }
            },
            { name = "path" },
            { name = "spell" },
          }),
          formatting = {
            format = function(_, item)
              local icons = {
                      Text = "",
                      Method = "m",
                      Function = "",
                      Constructor = "",
                      Field = "",
                      Variable = "",
                      Class = "",
                      Interface = "",
                      Module = "",
                      Property = "",
                      Unit = "",
                      Value = "",
                      Enum = "",
                      Keyword = "",
                      Snippet = "",
                      Color = "",
                      File = "",
                      Reference = "",
                      Folder = "",
                      EnumMember = "",
                      Constant = "",
                      Struct = "",
                      Event = "",
                      Operator = "",
                      TypeParameter = "",
                    }
              if icons[item.kind] then
                item.kind = icons[item.kind] .. " " .. item.kind
              end
              return item
            end,
          },
          experimental = {
            ghost_text = {
              hl_group = "LspCodeLens",
            },
          },
        }
      end,
    },
    {
      "L3MON4D3/LuaSnip",
      build = (not jit.os:find("Windows"))
          and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      opts = {
        history = true,
        delete_check_events = "TextChanged",
      },
      -- stylua: ignore
      keys = {
        {
          "<tab>",
          function()
            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
          end,
          expr = true, silent = true, mode = "i",
        },
        { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
      },
    },
    {
        "tversteeg/registers.nvim",
        name = "registers",
        keys = {
            { "\"",    mode = { "n", "v" } },
            { "<C-R>", mode = "i" }
        },
        cmd = "Registers",
        config = true,
    },
   'jbyuki/venn.nvim',
   "ellisonleao/glow.nvim",
}
