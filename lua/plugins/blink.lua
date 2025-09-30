-- lua/plugins/blink_super_tab.lua
return {
    -- 1) Blink: Super-Tab 手感 + 稳定设置
    {
        "saghen/blink.cmp",
        -- 如果你用的是锁版本，改成对应 tag/commit
        version = "*",
        opts = {
            -- 推荐先关：snippet 中自动弹列表，避免误选
            completion = {
                trigger = { show_in_snippet = true },
                list = {
                    -- snippet 中不预选，避免 <Tab> 误接受
                    selection = {
                        preselect = function(ctx)
                            return not require("blink.cmp").snippet_active({ direction = 1 })
                        end,
                    },
                },
            },

            -- 你来接管按键（不使用预设）
            keymap = {
                preset = "none",

                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },

                -- Super-Tab：候选可见→选中并接受；否则片段跳转；仍不行→原生 <Tab>
                ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                ["<C-n>"] = { "select_next", "fallback_to_mappings" },

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },
        },
    },

    -- 3) LSP 侧的稳态化：关 inline_completion / inlay hints；统一 offsetEncoding；可选关 semantic tokens
    {
        "neovim/nvim-lspconfig",
        init = function()
            -- 关内置 inline completion（0.10+）
            pcall(function()
                vim.lsp.inline_completion.enable(false)
            end)

            -- 默认关 inlay hints（热点问题，你遇到过列越界）
            vim.lsp.inlay_hint.enable(false)

            -- 统一 offsetEncoding，减少坐标换算错位（clangd/rust/ts 常用 utf-16）
            local caps = vim.lsp.protocol.make_client_capabilities()
            caps.offsetEncoding = { "utf-16" }

            -- 挂到全局，供各 server 复用
            vim.g.__blink_super_tab_caps = caps

            -- LspAttach 时做一些保护：必要时关 semantic tokens
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then
                        return
                    end

                    -- 如需彻底规避相关渲染竞态，可解开下一行
                    -- client.server_capabilities.semanticTokensProvider = nil
                end,
            })
        end,
        opts = {
            -- 如果你用 LazyVim 的 lspconfig 自动注册，这里把 capabilities 注入
            setup = {
                -- 对所有 server 注入统一 capabilities
                ["*"] = function(server, opts)
                    opts.capabilities = vim.tbl_deep_extend("force", opts.capabilities or {}, vim.g.__blink_super_tab_caps or {})
                end,
            },
        },
    },
}
