-- ~/.config/nvim/lua/plugins/format.lua
return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                -- NOTE: front end
                html = { "prettierd", "prettier" },
                css = { "prettierd", "prettier" },
                scss = { "prettierd", "prettier" },
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
            },
        },
    },
}
