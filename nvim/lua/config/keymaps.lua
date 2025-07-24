-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local Util = require("lazyvim.util")

vim.keymap.set("n", "<C-\\>", function()
  Util.terminal(nil, { cwd = Util.root(), float = true }) -- Keymap on Keyboard: Ctrl + Backslash
end, { desc = "Toggle Floating Terminal" })
vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle Floating Terminal" }) -- Keymap on Keyboard: Ctrl + Backslash
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>') -- Keymap on Keyboard: Left Arrow
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>') -- Keymap on Keyboard: Right Arrow
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>') --  Keymap on Keyboard: Up Arrow
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>') -- Keymap on Keyboard: Down Arrow
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true }) -- Keymap on Keyboard: Ctrl + h
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true }) -- Keymap on Keyboard: Ctrl + l
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true }) -- Keymap on Keyboard: Ctrl + j
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true }) -- Keymap on Keyboard: Ctrl + k
