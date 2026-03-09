-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
local group = vim.api.nvim_create_augroup("auto_reload_external_changes", { clear = true })

vim.api.nvim_create_autocmd("FileChangedShell", {
    group = group,
    callback = function(args)
        if vim.bo[args.buf].modified then
            vim.notify(
                "检测到外部修改，但当前 buffer 也有未保存改动，未自动覆盖",
                vim.log.levels.WARN
            )
            return
        end
        vim.cmd("silent! checktime")
    end,
})
