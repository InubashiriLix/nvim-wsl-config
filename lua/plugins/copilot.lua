if false then
    return {
        {
            "zbirenbaum/copilot.lua",
            opts = function(_, opts)
                local uv = vim.uv or vim.loop
                local node = vim.fn.exepath("node")

                opts.copilot_node_command = {
                    node ~= "" and node or "node",
                    "--max-old-space-size=768",
                }

                opts.server_opts_overrides = vim.tbl_deep_extend("force", opts.server_opts_overrides or {}, {
                    settings = {
                        advanced = {
                            inlineSuggestCount = 1,
                            listCount = 3,
                        },
                    },
                })

                opts.should_attach = function(bufnr, bufname)
                    if not vim.bo[bufnr].buflisted then
                        return false
                    end

                    if vim.bo[bufnr].buftype ~= "" then
                        return false
                    end

                    if vim.api.nvim_buf_line_count(bufnr) > 5000 then
                        return false
                    end

                    if bufname ~= "" then
                        local stat = uv.fs_stat(bufname)
                        if stat and stat.size and stat.size > 256 * 1024 then
                            return false
                        end
                    end

                    return true
                end
            end,
        },
    }
else
    return {}
end
