-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "J", "<C-d>", { noreap = true, silent = true })

-- !NOTE: for the NEORG
vim.keymap.set("n", "<leader>oj", "<cmd>Neorg journal today<CR>", { desc = "📅 打开今天的笔记" })
vim.keymap.set("n", "<leader>on", "<cmd>Neorg workspace notes<CR>", { desc = "📘 Neorg Notes" })
-- vim.keymap.set("n", "<leader>ogd", ":Neorg follow-link<CR>", { desc = "Neorg Follow Link" })
-- vim.api.nvim_set_keymap("n", "<C-Space>", "<cmd>Neorg action norg.qol.todo_items.toggle<CR>", { noremap = true, silent = true })
--
vim.keymap.set({ "n", "i", "v" }, "<F1>", "<Nop>", { desc = "Disable F1 key" }) -- Disable F1 key
vim.api.nvim_set_keymap("n", "<F4>", ":set spell!<CR>", { noremap = true, silent = true }) -- fuck with spelling check

vim.keymap.set("n", "<leader>cn", ":Neogen<CR>", { desc = "Generate docstring" })

require("config.f5")
