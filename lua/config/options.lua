-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- 光标所在的符号用黄色
-- vim.api.nvim_set_hl(0, "MatchParen", { fg = "#FFD700", bg = "none", bold = true })
--
-- -- 匹配的符号用淡蓝色
-- vim.api.nvim_set_hl(0, "Cursor", { fg = "#ADD8E6", bg = "none", bold = true })
vim.g.lazyvim_check_order = false
--
--
vim.api.nvim_set_hl(0, "MatchParen", { fg = "#FFD700", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "MatchParenMatched", { fg = "#ADD8E6", bg = "none", bold = true })

-- fucking fzf
-- vim.g.lazyvim_picker = "fzf"

-- =================== RUST CONFIG =====================
-- LSP Server to use for Rust.
-- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

-- LSP Server to use for Rust.
-- Set to "bacon-ls" to use bacon-ls instead of rust-analyzer.
-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

vim.o["clipboard"] = "unnamedplus"

vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
    cache_enable = 0,
}

-- 在 LazyVim 中配置代理
-- vim.env.http_proxy = "http://127.0.0.1:7890"
-- vim.env.https_proxy = "http://127.0.0.1:7890"

-- 设置缩进为 4 个空格
vim.opt.tabstop = 4 -- Tab 显示为 4 个空格
vim.opt.shiftwidth = 4 -- 自动缩进为 4 个空格
vim.opt.expandtab = true -- 将 Tab 转换为空格
vim.opt.softtabstop = 4 -- 输入 Tab 键时插入 4 个空格

vim.filetype.add({
    extension = {
        urdf = "xml",
        xacro = "xml",
    },
})

-- !WARNING: SILENCE! TREESITTER!!
vim.schedule(function()
    local orig = vim.notify
    vim.notify = function(msg, level, opts)
        if type(msg) == "string" then
            if msg:match("update%s+`?nvim%-treesitter`?") or msg:match("Please use `:Lazy` and update `nvim%-treesitter`") then
                return
            end
        end
        return orig(msg, level, opts)
    end
end)
