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


vim.api.nvim_create_autocmd("FileType", {
    pattern = "teal",
    callback = function(ev)
        vim.bo[ev.buf].commentstring = "-- %s"
    end,
    desc = "Set Teal comment string",
})

vim.api.nvim_create_user_command("CheckIkunBalance", function()
    -- call the system application in the /usr/bin/check_ikun_balance_with_session
    ---@param out vim.SystemCompleted
    local on_complete = function(out)
        if out.code ~= 0 then
            vim.notify("Check Error: \n" .. out.stderr, vim.log.levels.ERROR, {
                title = "Check Ikun Balance",
            })
        else
            vim.notify("Check Result: \n" .. out.stdout, vim.log.levels.INFO, {
                title = "Check Ikun Balance",
            })
        end
    end

    vim.system({ "check_ikun_balance_with_session" }, { text = true }, on_complete)
end, {})

vim.api.nvim_create_user_command("TypstCompile", function()
    -- get current buffer's file extension
    local cur_buf_ext = vim.fn.expand("%:e")
    -- vim.notify("Calling TypstCompile: Current buffer extension: " .. cur_buf_ext, vim.log.levels.DEBUG)

    -- get current buffer's file path
    local cur_buf_path = vim.fn.expand("%:p")
    -- vim.notify("Calling TypstCompile: Current buffer path: " .. cur_buf_path, vim.log.levels.DEBUG)

    -- get current buffer's file name without extension
    local cur_buf_name = vim.fn.expand("%:t:r")
    -- vim.notify("Calling TypstCompile: Current buffer name: " .. cur_buf_name, vim.log.levels.DEBUG)

    -- confirm whether there is a execuatable "typst"
    if vim.fn.executable("typst") == 0 then
        vim.notify("Typst is not installed", vim.log.levels.ERROR)
        return
    end

    -- check if the current buffer is a typst file
    if cur_buf_ext ~= "typ" then
        vim.notify("Current buffer is not a typst file", vim.log.levels.ERROR)
        return
    end

    -- use cur buf's path and name to construct the output path
    local output_dir = vim.fn.expand("%:p:r") .. ".pdf"
    -- callback function
    ---@param out vim.SystemCompleted
    local on_complete = function(out)
        if out.code ~= 0 then
            vim.notify("Typst Compile Error: \n" .. out.stderr, vim.log.levels.ERROR, {
                title = "Typst Compile",
            })
        else
            vim.notify("Typst Compile Success: code " .. out.code, vim.log.levels.INFO, {
                title = "Typst Compile",
            })
        end
    end

    -- use typst compile to compile the current buffer
    vim.system({ "typst", "compile", cur_buf_path, output_dir }, { text = true }, on_complete)
end, {})

-- 距离跑路还有多久
vim.api.nvim_create_user_command("RunMan", function()
    local input = vim.fn.input("Enter your sign off time in hh:mm format")
    local hour = tonumber(string.sub(input, 1, 2))
    local minute = tonumber(string.sub(input, 4, 5))
    vim.notify("Sign off time is " .. hour .. ":" .. minute, vim.log.levels.INFO)
    -- get current time:
    local current_time = os.date("*t")
    -- calculate the remaining time:
    local remaining_time = hour * 60 + minute - current_time.hour * 60 - current_time.min
    local remain_hour, remain_minute = math.floor(remaining_time / 60), math.floor(remaining_time % 60)
    vim.notify("Remaining time is " .. remain_hour .. ":" .. remain_minute, vim.log.levels.INFO)
end, {})
