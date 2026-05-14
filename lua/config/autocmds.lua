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

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("checkhealth lsp")
end, {})

vim.api.nvim_create_user_command("St", function()
    vim.cmd("restart")
end, {})

vim.api.nvim_create_user_command("ClangdHardRestart", function()
    local cwd = vim.fn.getcwd()
    local bufnr = vim.api.nvim_get_current_buf()

    -- 1. 先停掉当前 clangd client
    for _, client in ipairs(vim.lsp.get_clients({ name = "clangd" })) do
        client:stop(true)
    end

    -- 2. 等 clangd 真的退出一小会，再删 cache
    vim.defer_fn(function()
        local paths = {
            cwd .. "/.cache/clangd",
            cwd .. "/build/.cache/clangd",
            vim.fn.expand("~/.cache/clangd"),
        }

        for _, path in ipairs(paths) do
            if vim.uv.fs_stat(path) then
                vim.fn.delete(path, "rf")
                print("Deleted: " .. path)
            end
        end

        -- 3. 清掉当前 buffer 旧 diagnostic，避免看起来像没刷新
        vim.diagnostic.reset(nil, bufnr)

        -- 4. 重新启动 / 重新 attach clangd
        vim.defer_fn(function()
            vim.cmd("edit")
            vim.cmd("lsp restart clangd")
            print("clangd hard restarted")
        end, 300)
    end, 500)
end, {})
