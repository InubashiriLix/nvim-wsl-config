vim.keymap.set("n", "<leader>hp", function()
    -- tell whether current buffer type is pdf file
    local buffer = vim.api.nvim_buf_get_name(0)
    local file_path = buffer
    local is_pdf = file_path:match("%.pdf$") ~= nil
    if not is_pdf then
        vim.notify("current buffer is not a pdf file")
        return
    end

    -- don;t fuck with other errors like readable.
    local _, err = vim.ui.open(file_path)

    if err then
        vim.notify("failed to open pdf: " .. err, vim.log.levels.ERROR)
        return
    end

    vim.notify("opening pdf file")
end, { desc = "open current pdf in explorer" })

return {
    "arminveres/md-pdf.nvim",
    branch = "main", -- you can assume that main is somewhat stable until releases will be made
    lazy = true,
    keys = {
        {
            "<leader>hc",
            function()
                require("md-pdf").convert_md_to_pdf()
            end,
            desc = "Markdown preview",
        },
    },
    ---@type md-pdf.config
    opts = {},
}
