return {
  "echasnovski/mini.nvim",
  version = false, -- atau versi spesifik jika Anda mau
  config = function()
    require("mini.cursorword").setup()
  end,
}
