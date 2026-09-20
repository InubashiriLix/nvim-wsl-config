-- lua/plugins/ai/ai_keys_fix.lua
return {
    -- Avante：统一用 <leader>ac，禁用它的 <leader>aa
    {
        "yetone/avante.nvim",
        keys = {
            { "<leader>aa", false, mode = { "n", "x" } },
            { "<leader>acc", "<cmd>AvanteAsk<CR>", desc = "Ask Avante", mode = { "n", "x" } },

            { "<leader>ac", false, mode = { "n", "x" } },
            { "<leader>aca", "<cmd>AvanteChat<CR>", desc = "Chat with Avante", mode = { "n", "x" } },

            { "<leader>ae", false, mode = { "n", "x" } },
            { "<leader>ace", "<cmd>AvanteEdit<CR>", desc = "Edit Avante", mode = { "n", "x" } },

            { "<leader>af", false, mode = { "n", "x" } },
            { "<leader>acf", "<cmd>AvanteFocus<CR>", desc = "Focus Avante", mode = { "n", "x" } },

            { "<leader>ah", false, mode = { "n", "x" } },
            { "<leader>ach", "<cmd>AvanteHistory<CR>", desc = "Avante History", mode = { "n", "x" } },

            { "<leader>am", false, mode = { "n", "x" } },
            { "<leader>acm", "<cmd>AvanteModels<CR>", desc = "Select Avante Model", mode = { "n", "x" } },

            { "<leader>an", false, mode = { "n", "x" } },
            { "<leader>acn", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat", mode = { "n", "x" } },

            { "<leader>ap", false, mode = { "n", "x" } },
            { "<leader>acp", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider", mode = { "n", "x" } },

            { "<leader>ar", false, mode = { "n", "x" } },
            { "<leader>acr", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante", mode = { "n", "x" } },

            { "<leader>as", false, mode = { "n", "x" } },
            { "<leader>acs", "<cmd>AvanteStop<CR>", desc = "Stop Avante", mode = { "n", "x" } },

            { "<leader>at", false, mode = { "n", "x" } },
            { "<leader>act", "<cmd>AvanteToggle<CR>", desc = "Toggle Avante", mode = { "n", "x" } },
        },
    },

    {
        "folke/sidekick.nvim",
        init = function()
            pcall(vim.keymap.del, "i", "<Space>ai")  -- 清理旧映射
            pcall(vim.keymap.del, "i", "<leader>ai") -- 以防有插件按 <leader> 记录
            pcall(vim.keymap.del, "t", "<leader>ai")
        end,
        keys = {
            { "<leader>aa", false, mode = { "n", "x" } }, -- 不让 sidekick 抢占 aa
            { "<leader>ad", false, mode = { "n", "x" } },
            {
                -- aad 已用于禁用 NES，使用 aax 分离 CLI 会话。
                "<leader>aax",
                function()
                    require("sidekick.cli").close()
                end,
                desc = "Detach a CLI Session",
                mode = { "n", "x" },
            },
            {
                "<leader>aai",
                function()
                    require("sidekick.cli").toggle()
                end,
                desc = "Sidekick Toggle CLI",
                mode = { "n", "x" },
            },
            {
                "<leader>aaf",
                function()
                    require("sidekick.cli").focus()
                end,
                desc = "Sidekick Focus CLI",
                mode = { "n", "x" },
            },
            {
                "<leader>aah",
                function()
                    require("sidekick.cli").hide()
                end,
                desc = "Sidekick Hide CLI",
                mode = { "n", "x" },
            },
            {
                -- we use this to trigger the prompt panel in the normal mode
                "<leader>aao",
                function()
                    require("sidekick.cli").prompt()
                end,
                desc = "Sidekick Open Prompt Panel",
                mode = { "n", "x" },
            },
            {
                "<leader>aas",
                function()
                    vim.cmd("Sidekick nes enable")
                    vim.notify("Sidekick NES enabled", vim.log.levels.INFO, {
                        title = "Sidekick",
                        icon = "🤖",
                    })
                end,
                desc = "Sidekick NES Enable",
                mode = { "n", "x" },
            },
            {
                "<leader>aad",
                function()
                    vim.cmd("Sidekick nes disable")
                    vim.notify("Sidekick NES disabled", vim.log.levels.INFO, {
                        title = "Sidekick",
                        icon = "🛑",
                    })
                end,
                desc = "Sidekick NES Disable",
                mode = { "n", "x" },
            }
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
