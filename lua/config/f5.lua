local api = vim.api
local uv = vim.loop

-- 2. 找到用户自己用 :terminal 打开的第一个内置终端 buffer
local function find_term_buf()
    for _, buf in ipairs(api.nvim_list_bufs()) do
        if api.nvim_buf_is_valid(buf) and api.nvim_buf_get_option(buf, "buftype") == "terminal" then
            return buf
        end
    end
    return nil
end

local function send_to_term(cmd)
    local buf = find_term_buf()
    if not buf then
        return vim.notify("⚠️ 请先用 :terminal 打开一个终端", vim.log.levels.WARN)
    end
    local chan = vim.b[buf].terminal_job_id
    if not chan then
        return vim.notify("⚠️ 终端尚未准备就绪", vim.log.levels.ERROR)
    end
    vim.fn.chansend(chan, cmd .. "\r")
end

vim.keymap.set("n", "<F5>", function()
    local ft = vim.bo.filetype

    -- Markdown：浏览器预览
    if ft == "markdown" then
        return vim.cmd("MarkdownPreview")
    end

    -- Python：python <file>
    if ft == "python" then
        local file = vim.fn.expand("%:p")
        return send_to_term("python " .. vim.fn.shellescape(file))
    end

    -- 其它文件类型
    vim.notify("F5 只在 Markdown / Python / LÖVE / ESP-IDF 项目中有效", vim.log.levels.INFO)
end, { desc = "F5 → Build/Run" })
