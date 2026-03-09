vim.g.tokyonight_transparent = false

function vim.g.toggle_tokyonight_transparent()
    vim.g.tokyonight_transparent = not vim.g.tokyonight_transparent

    require("tokyonight").setup({
        transparent = vim.g.tokyonight_transparent,
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },
    })

    -- 关键：必须重新加载 colorscheme
    vim.cmd("colorscheme tokyonight")

    return vim.g.tokyonight_transparent
end

return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- 很重要，主题必须立即加载
        priority = 1000,
        opts = function()
            return {
                transparent = vim.g.tokyonight_transparent,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
            }
        end,
    },
}
