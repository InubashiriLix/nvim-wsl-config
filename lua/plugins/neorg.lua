return {
    {
        "nvim-neorg/neorg",
        ft = "norg",
        build = ":Neorg sync-parsers", -- 关键：同步 norg 相关解析器
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = { config = { workspaces = { notes = "~/notes" } } },
            },
        },
    },
}
