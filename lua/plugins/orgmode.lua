return {
    {
        "nvim-orgmode/orgmode",
        dependencies = {
            "akinsho/org-bullets.nvim",
            "massix/org-checkbox.nvim",
        },
        event = "VeryLazy",
        ft = { "org", "orgagenda" },
        cmd = "Org",
        config = function()
            require("orgmode").setup({
                org_agenda_files = "~/Dropbox/orgfiles/**/*",
                org_default_notes_file = "~/Dropbox/orgfiles/refile.org",
                org_todo_keywords = {
                    "TODO",
                    "ACTIVE",
                    "PARTIAL",
                    "PENDING",
                    "|",
                    "CANCELED",
                    "DONE",
                },
                org_todo_keyword_faces = {
                    TODO = ":foreground #c0caf5 :weight bold",
                    ACTIVE = ":foreground #7dcfff :weight bold :slant italic",
                    PARTIAL = ":foreground #9ece6a :weight bold :slant italic",
                    PENDING = ":foreground #faba4a :weight bold :slant italic",
                    CANCELED = ":foreground #bb9af7 :weight bold",
                    DONE = ":foreground #ff899d :weight bold",
                },
                org_ellipsis = "...",
                win_split_mode = "vertical",
                org_hide_leading_stars = false,
                org_adapt_indentaion = false,
                org_startup_indented = true,
                org_id_link_to_org_use_id = true,
                org_use_tag_inheritance = true,
                org_tags_column = 0,
                org_cycle_separator_lines = 0,
                org_blank_before_new_entry = {
                    heading = true,
                    plain_list_item = true,
                },
                org_priority_highest = "A",
                org_priority_default = "B",
                org_priority_lowest = "F",
                org_deadline_warning_days = 0,
                folds = {
                    colored = true,
                },
                agenda = {
                    preview_window = {
                        border = "rounded",
                    },
                },
            })
        end,
    },
    {
        "akinsho/org-bullets.nvim",
        event = "VeryLazy",
        config = function()
            require("org-bullets").setup()
        end,
    },
    {
        "massix/org-checkbox.nvim",
        event = "VeryLazy",
        config = function()
            require("orgcheckbox").setup()
        end,
        ft = { "org" },
    },
    {
        "hamidi-dev/org-list.nvim",
        event = "VeryLazy",
        config = function()
            require("org-list").setup({
                mapping = {
                    key = "<leader>oL", -- nvim-orgmode users: you might want to change this to <leader>olt
                    desc = "org cycle list types",
                },
                checkbox_toggle = {
                    enabled = true,
                    key = "<C-,>", -- Change the checkbox toggle key
                    desc = "Toggle checkbox state",
                    filetypes = { "org", "markdown" }, -- Add more filetypes as needed
                },
            })
        end,
    },
}
