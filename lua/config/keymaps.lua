-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- NOTE: sidekick CLI toogle for sidekick.nvim
-- vim.keymap.set({ "n", "i", "x", "t" }, "<leader>ai", function()
--     require("sidekick.cli").toggle()
-- end, { desc = "Sidekick Toggle (no Ctrl)" })

-- vim.keymap.set("n", "<leader>ai", "<cmd>sidekick cli toggle<CR>", { desc = "Sidekick Toggle" })
--
vim.keymap.set("n", "<F6>", "<cmd>Sidekick nes disable<CR>", { desc = "disable side kick nes" })
vim.keymap.set("n", "<F7>", "<cmd>Sidekick nes enable<CR>", { desc = "enable side kick nes" })
