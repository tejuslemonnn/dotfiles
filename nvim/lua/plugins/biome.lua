return {
  -- 1. Tambahkan Biome ke nvim-lspconfig (Aman, ini di-merge)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        biome = {}, -- Aktifkan LSP Biome
      },
    },
  },

  -- 2. Atur agar Biome jadi Formatter utama (Pengganti Prettier)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Paksa file JS/TS pakai Biome, bukan Prettier
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
      },
    },
  },
}
