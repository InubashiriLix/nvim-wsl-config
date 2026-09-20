-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- set 'jk', 'jj', 'kk', 'kj' to exit insert mode
vim.keymap.set("i", "<Esc>", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "kk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })


-- enable and disable theme (I use tokyonight now) transparent
vim.keymap.set("n", "<leader>uu", function()
    local current_state = vim.g.toggle_tokyonight_transparent()
    vim.cmd("colorscheme tokyonight") -- update the colorscheme to apply the change
    vim.notify("Tokyonight transparent mode" .. (current_state and " enabled" or " disabled"), vim.log.levels.INFO, {
        title = "Tokyonight Theme",
        icon = "🎨",
    })
end, { desc = "Toggle Tokyonight Theme" })

-- Leave terminal-mode so the terminal buffer can be navigated like a normal buffer.
vim.keymap.set("t", "<C-q>", "<cmd>stopinsert<cr>", { desc = "Terminal Normal Mode" })

-- kill all the marks
vim.keymap.set("n", "<leader>md", function()
    vim.cmd("delmarks!")
    vim.cmd("delmarks A-Z0-9")
    vim.cmd("wshada!")
end, { desc = "Delete all marks" })

-- FUCK F1
vim.keymap.set({ "n", "i", "v" }, "<F1>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>cb",
    function()
        require("blink.cmp").reload()
        vim.notify('blink.cmp reloaded')
    end,
    { desc = "Reload blink.nvim cmp" }
)
