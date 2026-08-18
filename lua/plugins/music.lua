---@type AmbientProgressConfig
local progress = {
    enabled = true,
    layout = {
        width = 30, -- ambient 状态栏文本的固定宽度
    },
    track = {
        enabled = true,
        width = 20, -- 当前歌曲名的最大宽度
        scroll = true,
        scroll_separator = "",
    },
    bar = {
        enabled = false,
        style = "block",
        width = 6, -- 进度条主体宽度，不包含 bar.left/bar.right
    },
    time = {
        enabled = true,
    },
    refresh = {
        interval_ms = 500,
    },
    component = {
        frame = {
            enabled = true,
            left = "",
            right = "",
            padding = " ",
        },
        -- lualine 的 separator 是 transition separator，同背景时可能不可见。
        -- 需要稳定可见的边框时，用上面的 frame.left/frame.right。
    },
    highlight = {
        default = {
            fg = "#7CA0F1",
            bg = "#1e2032",
            gui = "bold",
        },
        states = {
            playing = {
                fg = "#C2E78D",
                bg = "#1e2032",
                gui = "italic",
            },
            interval = {
                fg = "#7CA0F1",
                bg = "#1e2032",
                gui = "none",
            },
            stopped = {
                fg = "#7CA0F1",
                bg = "#1e2032",
                gui = "none",
            },
            error = {
                fg = "#000000",
                bg = "#f38ba8",
                gui = "bold",
            },
        },
    },
}

---@type AmbientConfig
local opts = {
    enable = true,
    recursive_depth = 2,
    music_dirs = {
        "~/Music/Ambient.nvim/default/",
        "~/Music/Ambient.nvim/albums/In the Usual Motion/",
        "~/Music/Ambient.nvim/albums/In the Unusual Motion/",
        "~/Music/Ambient.nvim/albums/Signalis/",
        "~/Music/Ambient.nvim/albums/Necrophobia/",
        "~/Music/Ambient.nvim/albums/Casualities: Unknown/"

    },
    mode = "continuous",
    volume = 80,
    progress = progress,
    track_popup = {
        enabled = true,
        position = "bottom_left",
        duratoin_ms = 5000,
        width = 38,
        height = 7,
        margin = {
            row = 1,
            col = 1,
        },
        cover = { enabled = true, backend = "image.nvim" },
    },
    show_notification = {
        disable_all = false,
        when_finish_setup = true,
        when_show_total_music_count = false,
        when_start_playing = false,
        when_toggle_playing_state = false,
    }
}

return {
    {
        "InubashiriLix/ambient.nvim",
        -- dir = "/home/inubashiri/proj/neovim-plugin/ambient.nvim",
        name = "ambient.nvim",
        main = "ambient",
        event = "VeryLazy",
        cmd = {
            "Ambient"
        },
        opts = opts,
        config = function(_, opts)
            require("ambient").setup(opts)
        end,
    },
}
