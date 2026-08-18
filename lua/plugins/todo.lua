return {
    -- "InubashiriLix/TodoAnxiety.nvim",
    dir = "/home/inubashiri/proj/neovim-plugin/TodoAnxiety.nvim",
    dependencies = {
        "kkharji/sqlite.lua",
        "MunifTanjim/nui.nvim",
    },

    config = function()
        require("todo").setup({
            reminders = {
                enabled = true,
                sound = {
                    path = vim.fn.expand("~/Music/Todo.nvim/mission.mp3"),
                    command = {
                        "mpv",
                        "--no-video",
                        "--really-quiet",
                    },
                },
            },
        })
    end,
}
