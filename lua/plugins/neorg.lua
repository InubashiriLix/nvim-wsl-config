return {
    "nvim-neorg/neorg",

    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    version = "*",
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        })

        -- Set foldlevel and conceallevel for Neorg buffers only
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "norg",
            callback = function()
                vim.wo.foldlevel = 99
                vim.wo.conceallevel = 2
            end,
        })
    end,
}
