return {
  {
    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",
    opts = {
      perspective = {
        priority = "current",
        fallback = "first",
        root_tell = false,
      },
      mappings = {
        MkdnNextLink = { "n", "<Tab>" },
        MkdnPrevLink = { "n", "<S-Tab>" },
        MkdnNextHeading = { "n", "<leader>]" },
        MkdnPrevHeading = { "n", "<leader>[" },
        MkdnGoBack = { "n", "<BS>" },
        MkdnGoForward = { "n", "<Del>" },
        MkdnFollowLink = { { "n", "v" }, "<CR>" },
        MkdnDestroyLink = { "n", "<M-CR>" },
        MkdnYankAnchorLink = { "n", "ya" },
        MkdnYankFileAnchorLink = { "n", "yfa" },
        MkdnIncreaseHeading = { "n", "+" },
        MkdnDecreaseHeading = { "n", "-" },
        MkdnToggleToDo = { "n", "zz" },
        MkdnNewListItem = false,
      },
    },
  },
}
