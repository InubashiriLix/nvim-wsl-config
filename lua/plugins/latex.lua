-- ~/.config/nvim/lua/plugins/latex.lua
return {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
        local pdf_viewer = vim.fn.executable("firefox") == 1 and "firefox" or "xdg-open"

        -- 编译器设置
        vim.g.vimtex_compiler_method = "latexmk"
        vim.g.vimtex_compiler_latexmk = {
            build_dir = "",
            callback = 1,
            continuous = 1,
            executable = "latexmk",
            options = {
                "-pdf",
                "-interaction=nonstopmode",
                "-synctex=1",
            },
        }

        -- PDF 查看器设置
        vim.g.vimtex_view_method = "general"
        vim.g.vimtex_view_general_viewer = pdf_viewer
        vim.g.vimtex_view_general_options = "@pdf"

        -- 不自动弹出 quickfix
        vim.g.vimtex_quickfix_mode = 0

        -- 快捷键
        local opts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap("n", "<leader>ll", "<cmd>VimtexCompile<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>lv", "<cmd>VimtexView<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>lc", "<cmd>VimtexCompileStop<CR>", opts)

        -- 自动折叠章节
        vim.g.vimtex_fold_enabled = true
    end,
}
