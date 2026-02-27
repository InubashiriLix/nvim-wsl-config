return {
    "uga-rosa/translate.nvim",
    cmd = "Translate",
    opts = {
        default = {
            command = "translate_shell",
        },
        preset = {
            command = {
                -- 这里可以给 trans 追加参数（可选）
                -- translate.nvim 的 preset 会先放入：-b -no-ansi -no-autocorrect
                -- 你写的 args 会被追加到后面
                translate_shell = {
                    args = { "-b", "-no-ansi" },
                },
            },
        },
    },
    keys = {
        -- 普通模式：翻译当前行到中文
        { "<leader>tz", "<cmd>Translate zh-CN<cr>", desc = "Translate → zh-CN (line)" },
        -- 普通模式：翻译当前行到英文
        { "<leader>te", "<cmd>Translate en<cr>", desc = "Translate → en (line)" },

        -- 可视模式：翻译选中内容到中文
        { "<leader>tz", ":Translate zh-CN<cr>", mode = "v", desc = "Translate → zh-CN (selection)" },
        -- 可视模式：翻译选中内容到英文
        { "<leader>te", ":Translate en<cr>", mode = "v", desc = "Translate → en (selection)" },
    },
}
