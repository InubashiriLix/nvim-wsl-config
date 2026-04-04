-- shit tho
-- vim.keymap.set("n", "<leader>lt", function()
--     require("live-server-nvim").toggle()
-- end, { desc = "live-server" })

vim.keymap.set("n", "<leader>ls", "<cmd>LiveServerStaert -f<CR>", { desc = "live-server start" })

vim.keymap.set("n", "<leader>le", "<cmd>LiveServerStop<CR>", { desc = "live-server stop" })

vim.keymap.set("n", "<leader>lt", "<cmd>LiveServerToggle<CR>", { desc = "live-server stop" })

return {
    "ngtuonghy/live-server-nvim",
    event = "VeryLazy",
    build = ":LiveServerInstall",
    config = function()
        require("live-server-nvim").setup({
            custom = {
                "--port=6020",
                "--no-css-inject",
            },

            serverPath = vim.fn.stdpath("data") .. "/live-server/", --default
            open = "folder", -- folder|cwd     --default
        })
    end,
}
