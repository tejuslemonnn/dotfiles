-- Disarankan disimpan di lua/plugins/dap.lua

return {
  -- Jadikan nvim-dap sebagai plugin utama
  "mfussenegger/nvim-dap",

  -- Definisikan semua plugin terkait sebagai dependensi
  dependencies = {
    -- UI untuk DAP, membuatnya terlihat bagus
    "rcarriga/nvim-dap-ui",

    -- Plugin untuk mengintegrasikan DAP dengan Mason (otomatis instal adapter)
    "jay-babu/mason-nvim-dap.nvim",

    -- Contoh: Tambahkan dukungan debug untuk bahasa Go
    "leoluz/nvim-dap-go",

    -- (Opsional) nvim-nio adalah dependensi untuk beberapa plugin,
    -- Lazy.nvim biasanya menanganinya, tapi bisa juga eksplisit
    "nvim-neotest/nvim-nio",
  },

  -- Semua konfigurasi terpusat di sini
  config = function()
    -- 1. Panggil modul sekali di awal untuk efisiensi
    local dap = require("dap")
    local dapui = require("dapui")

    -- 2. Setup nvim-dap-ui
    dapui.setup({
      -- Konfigurasi layout, ikon, dll. bisa ditambahkan di sini
      -- Contoh:
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
    })

    -- 3. Otomatisasi UI: buka saat debug mulai, tutup saat selesai
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- 4. Setup mason-nvim-dap untuk mengelola debug adapter secara otomatis
    require("mason-nvim-dap").setup({
      ensure_installed = { "go" }, -- Pastikan adapter Go terinstal
      automatic_installation = true, -- Instal adapter secara otomatis jika belum ada
    })

    -- 5. Panggil setup untuk konfigurasi bahasa spesifik
    require("dap-go").setup()

    -- 6. Definisikan keymap dengan cara yang lebih bersih dan efisien
    -- Menggunakan referensi fungsi langsung, bukan memanggil `require` berulang kali
    vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Toggle DAP UI" })
    vim.keymap.set("n", "<F11>", dap.continue, { desc = "Continue Debugging" })
    vim.keymap.set("n", "<F9>", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<F10>", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" }) -- Typo diperbaiki
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Set Conditional Breakpoint" })
  end,
}
