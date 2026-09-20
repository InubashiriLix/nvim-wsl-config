-- the xmake mapping
-- vim.keymap.set("n", "<leader>m", { desc = "+xmake" })
vim.keymap.set("n", "<leader>mb", "<cmd>Xmake build<CR>", { desc = "Xmake build" })
vim.keymap.set("n", "<leader>mc", "<cmd>Xmake clean<CR>", { desc = "Xmake clean" })
vim.keymap.set("n", "<leader>mr", "<cmd>Xmake run<CR>", { desc = "Xmake run" })
vim.keymap.set("n", "<leader>mD", "<cmd>Xmake debug<CR>", { desc = "Xmake debug" })
vim.keymap.set("n", "<leader>mR", "<cmd>Xmake run all<CR>", { desc = "Xmake run all" })
vim.keymap.set("n", "<leader>mm", "<cmd>Xmake mode<CR>", { desc = "Xmake set mode" })
vim.keymap.set("n", "<leader>mp", "<cmd>Xmake select platform<CR>", { desc = "Xmake sel platform" })
vim.keymap.set("n", "<leader>ma", "<cmd>Xmake select arch<CR>", { desc = "Xmake sel arch" })
vim.keymap.set("n", "<leader>mt", "<cmd>Xmake select toolchain<CR>", { desc = "Xmake sel toolchain" })

return {
    {
        "Mythos-404/xmake.nvim",
        version = "^3",
        lazy = true,
        event = "BufReadPost",
        config = true,
        opts = {

            -- Configuration when saving `xmake.lua`
            on_save = {
                -- Reload project information
                reload_project_info = true,
                -- Configuration for generating `compile_commands.json`
                lsp_compile_commands = {
                    enable = true,
                    -- Directory name (relative path) for output file
                    output_dir = "build",
                },
            },

            -- Lsp related configuration
            lsp = {
                enable = true,
                language = "en", ---@type "en"|"zh-cn"
            },

            -- Debugger related configuration
            debuger = {
                -- Checks the project's build mode, and if it’s not among the modes below,
                -- it will automatically switch to `debug` mode for build/run,
                -- and then switch back to the original build mode
                rulus = { "debug", "releasedbg" },
                -- Dap configuration, please refer to Dap and the debugger's documentation
                dap = {
                    name = "Xmake Debug",
                    type = "codelldb",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    console = "integratedTerminal",
                    stopOnEntry = false,
                    runInTerminal = true,
                },
            },

            -- Notification related settings
            notify = {
                -- Icons for completion
                icons = {
                    error = "",
                    successfully = "",
                },
                -- Icons for progress display
                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                -- Refresh rate for the progress bar
                refresh_rate_ms = 100,
            },

            -- Runner configuration
            runner = {
                -- Select which backend to use
                type = "toggleterm", ---@type "toggleterm"|"terminal"|"quickfix"|"snacks"

                config = {
                    toggleterm = {
                        direction = "float", ---@type "vertical"|"horizontal"|"tab"|"float"
                        singleton = true,
                        auto_scroll = true,
                        close_on_success = false,
                    },
                    terminal = {
                        name = "Runner Terminal",
                        prefix_name = "[Xmake]: ",
                        split_size = 15,
                        split_direction = "horizontal", ---@type "vertical"|"horizontal"
                        focus = true,
                        focus_auto_insert = true,
                        auto_resize = true,
                        close_on_success = false,
                    },
                    quickfix = {
                        show = "always", ---@type "always"|"only_on_error"
                        size = 15,
                        position = "botright", ---@type "vertical"|"horizontal"|"leftabove"|"aboveleft"|"rightbelow"|"belowright"|"topleft"|"botright"
                        close_on_success = false,
                    },
                    snacks = {
                        position = "float",
                        interactive = true,
                    },
                },
            },
            -- Executor configuration
            execute = {
                -- Select which backend to use
                type = "quickfix", ---@type "toggleterm"|"terminal"|"quickfix"|"snacks"

                config = {
                    toggleterm = {
                        direction = "float", ---@type "vertical"|"horizontal"|"tab"|"float"
                        singleton = true,
                        auto_scroll = true,
                        close_on_success = true,
                    },
                    terminal = {
                        name = "Executor Terminal",
                        prefix_name = "[Xmake]: ",
                        split_size = 15,
                        split_direction = "horizontal", ---@type "vertical"|"horizontal"
                        focus = false,
                        focus_auto_insert = true,
                        auto_resize = true,
                        close_on_success = true,
                    },
                    quickfix = {
                        show = "only_on_error", ---@type "always"|"only_on_error"
                        size = 15,
                        position = "botright", ---@type "vertical"|"horizontal"|"leftabove"|"aboveleft"|"rightbelow"|"belowright"|"topleft"|"botright"
                        close_on_success = true,
                    },
                    snacks = {
                        position = "float",
                        interactive = true,
                    },
                },
            },

            -- Enable development mode
            dev_debug = true,
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            sections = {
                lualine_y = {
                    {
                        function()
                            if not vim.g.loaded_xmake then return "" end
                            local Info = require("xmake.info")
                            if Info.mode.current == "" then return "" end
                            if Info.target.current == "" then return "Xmake: Not Select Target" end
                            return ("%s(%s)"):format(Info.target.current, Info.mode.current)
                        end,
                        cond = function()
                            return vim.o.columns > 100
                        end,
                    }
                }
            }
        }
    }
}
