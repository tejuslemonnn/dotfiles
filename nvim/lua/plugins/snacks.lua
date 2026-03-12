return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
    },
    explorer = {
      enabled = true,
      auto_close = false,
      hidden = true,
      ignored = true,
      sources = {
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },
    picker = {
      sources = {
        explorer = {
          auto_close = true,
          focus = "list",
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
