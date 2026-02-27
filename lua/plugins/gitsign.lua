return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            -- add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },

        current_line_blame = true,

        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 800,
            ignore_whitespace = false,
        },

        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d %H:%M> • <summary>",

        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,

        watch_gitdir = {
            follow_files = true,
        },

        attach_to_untracked = true,
        update_debounce = 100,
        max_file_length = 40000,

        preview_config = {
            border = "rounded",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
    },
}
