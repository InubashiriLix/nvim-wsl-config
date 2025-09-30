return {
    -- 1) 彻底禁用常见的 Python 环境插件（双保险：enabled=false + cond=false）
    { "linux-cultist/venv-selector.nvim", enabled = false, cond = false, optional = true },
    { "AckslD/swenv.nvim", enabled = false, cond = false, optional = true },
    { "direnv/direnv.vim", enabled = false, cond = false, optional = true },

    -- 2) 粗暴拦截：删除所有监听 User VenvActivated 的自动命令，防止任何“重载终端/重启LSP”
    {
        "LazyVim/LazyVim",
        init = function()
            local function nuke_venv_autocmds()
                for _, a in ipairs(vim.api.nvim_get_autocmds({ event = "User", pattern = "VenvActivated" })) do
                    pcall(vim.api.nvim_del_autocmd, a.id)
                end
            end
            -- 兜底：就算有人还是发了 VenvActivated，我们也立刻清理并“吞掉”它
            vim.api.nvim_create_autocmd("User", {
                group = vim.api.nvim_create_augroup("NoVenvAutoReloadTrap", { clear = true }),
                pattern = "VenvActivated",
                callback = nuke_venv_autocmds,
            })
        end,
    },

    -- 3) 防止有人借 ToggleTerm 去“重启所有终端”
    {
        "akinsho/toggleterm.nvim",
        optional = true,
        init = function()
            vim.api.nvim_create_autocmd("User", {
                group = vim.api.nvim_create_augroup("BlockTermReloadOnVenv", { clear = true }),
                pattern = "VenvActivated",
                callback = function()
                    -- 故意什么都不做：拦截“重载终端”的习惯性回调
                end,
            })
        end,
    },
}
