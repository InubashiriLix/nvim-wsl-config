-- lua/plugins/ai-keys-fix.lua
return {
    -- Avante：统一用 <leader>ac，禁用它的 <leader>aa
    {
        "yetone/avante.nvim",
        keys = {
            { "<leader>aa", false, mode = { "n", "x" } },
            { "<leader>ac", "<cmd>AvanteAsk<CR>", desc = "Ask Avante", mode = { "n", "x" } },
        },
    },

    -- Sidekick：只在 Normal/Visual 模式映射；先删掉任何插入模式的残留映射
    {
        "folke/sidekick.nvim",
        init = function()
            pcall(vim.keymap.del, "i", "<Space>ai") -- 清理旧映射
            pcall(vim.keymap.del, "i", "<leader>ai") -- 以防有插件按 <leader> 记录
            pcall(vim.keymap.del, "t", "<leader>ai")
        end,
        keys = {
            { "<leader>aa", false, mode = { "n", "x" } }, -- 不让 sidekick 抢占 aa
            {
                "<leader>ai",
                function()
                    require("sidekick.cli").toggle()
                end,
                desc = "Sidekick Toggle CLI",
                mode = { "n", "x" },
            },
            -- 如果你真想插入模式也能触发，建议别用空格前缀，换成不影响打字的序列（示例，默认禁用）：
            -- { ";;i", function()
            --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            --     require("sidekick.cli").toggle()
            --   end,
            --   mode = "i", desc = "Sidekick Toggle (insert, ';;i')" },
        },

        opts = {
            nes = { enabled = false },
            cli = {
                tools = {
                    -- fix the proxying failed issue under niri with clash-rev / flclash's system proxy mode
                    -- using injecting the proxy env vars to the codex cli process
                    proxy_codex_flclash = {
                        cmd = { "codex" },
                        url = "https://github.com/openai/codex",
                        resume = { "resume" },
                        continue = { "resume", "--last" },
                        env = {
                            HTTP_PROXY = "http://127.0.0.1:7890",
                            HTTPS_PROXY = "http://127.0.0.1:7890",
                            NO_PROXY = "localhost,127.0.0.1,::1",

                            http_proxy = "http://127.0.0.1:7890",
                            https_proxy = "http://127.0.0.1:7890",
                            no_proxy = "localhost,127.0.0.1,::1",
                        },
                    },
                    proxy_codex_clash_rev = {
                        cmd = { "codex" },
                        url = "https://github.com/openai/codex",
                        resume = { "resume" },
                        continue = { "resume", "--last" },
                        env = {
                            HTTP_PROXY = "http://127.0.0.1:7897",
                            HTTPS_PROXY = "http://127.0.0.1:7897",
                            NO_PROXY = "localhost,127.0.0.1,::1",

                            http_proxy = "http://127.0.0.1:7897",
                            https_proxy = "http://127.0.0.1:7897",
                            no_proxy = "localhost,127.0.0.1,::1",
                        },
                    },
                },
            },
        },
    },
}
