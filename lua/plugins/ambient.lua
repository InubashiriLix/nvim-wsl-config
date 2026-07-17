return {
    {
        "InubashiriLix/ambient.nvim",

        name = "ambient.nvim",
        main = "ambient",
        event = "VeryLazy",
        cmd = {
            "AmbientStart",
            "AmbientStop",
            "AmbientToggle",
            "AmbientNext",
            "AmbientStatus",
            "AmbientProgressToggle",
        },
        ---@type AmbientConfig
        opts = {
            music_dirs = {
                "/home/inubashiri/proj/neovim-plugin/ambient.nvim/test-music",
            },
            mode = "interval_random",
            volume = 80,
            interval = {
                min_ms = 1000 * 60 * 3,
                max_ms = 1000 * 60 * 5,
            },
            progress = {
                enabled = true,
                update_interval_ms = 500,
                color = {
                    fg = "#ffffff",
                    bg = "#5c7fe5",
                    gui = "italic",
                },
            },
        },
        config = function(_, opts)
            require("ambient").setup(opts)
        end,
    },
}
