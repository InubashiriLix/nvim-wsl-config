return {
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        opts = {
            -- 只用 pattern 方式识别项目
            detection_methods = { "pattern" },
            -- 你的自定义标记文件
            patterns = { ".proj" },

            -- 常用项（根据喜好改）
            manual_mode = false, -- 自动切换 cwd
            silent_chdir = true, -- 静默切换，不弹消息
            scope_chdir = "tab", -- 每个标签页独立 cwd：也可设 "win" 或 "global"
            ignore_lsp = {}, -- 我们不用 LSP 检测，所以无所谓
            exclude_dirs = {}, -- 需要排除的路径可加到这里
            datapath = vim.fn.stdpath("data"),
        },
        config = function(_, opts)
            require("project_nvim").setup(opts)
            -- 如果装了 telescope，就把 projects 扩展挂上（LazyVim 通常自带）
            pcall(function()
                require("telescope").load_extension("projects")
            end)
        end,
        keys = {
            -- 快捷键：列出项目（需要 telescope）
            {
                "<leader>fp",
                function()
                    require("telescope").extensions.projects.projects()
                end,
                desc = "Projects (project.nvim)",
            },
        },
    },
}
