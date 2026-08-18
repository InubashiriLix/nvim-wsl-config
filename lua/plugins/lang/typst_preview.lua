return {
    {
        "chomosuke/typst-preview.nvim",
        lazy = false, -- 或者 ft = "typst"
        version = "1.*",
        opts = {
            -- 默认就能用；想指定浏览器可以填 open_cmd
            -- open_cmd = "firefox %s",
        },
        keys = {
            { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", desc = "Typst Preview Toggle" },
            { "<leader>ts", "<cmd>TypstPreviewStop<cr>", desc = "Typst Preview Stop" },
        },
    },
}
