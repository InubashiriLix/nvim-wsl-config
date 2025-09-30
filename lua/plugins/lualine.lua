return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            sections = {
                lualine_c = { "filename", "filetype" },
                lualine_x = { "encoding", "fileformat", "filetype", 'os.date("%H:%M")' },
            },
        })
    end,
}
