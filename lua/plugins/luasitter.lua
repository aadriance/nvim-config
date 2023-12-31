return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- custom list of LSPs I care about
    opts = {
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
        "norg_meta",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "rust-analyzer",
        "codespell",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "f3fora/cmp-spell" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "spell" },
        {
          name = "buffer",
          option = {
            -- Auto complete from all open buffers
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
      }))
    end,
  },
}
