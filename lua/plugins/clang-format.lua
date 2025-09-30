return {
    -- 用 conform 做格式化并指定 C/C++ 等走 clang-format
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            -- opts.format_on_save = function(bufnr)
            --     -- 可按需调小/调大
            --     return { timeout_ms = 1000, lsp_fallback = true }
            -- end

            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft.c = { "clang-format" }
            opts.formatters_by_ft.cpp = { "clang-format" }
            opts.formatters_by_ft.cuda = { "clang-format" }
            opts.formatters_by_ft.proto = { "clang-format" }

            -- 可选：给 clang-format 传默认风格（当没有 .clang-format 时）
            opts.formatters = opts.formatters or {}
            opts.formatters["clang-format"] = {
                prepend_args = { "--fallback-style=LLVM" }, -- 也可换成 Google/Chromium/Mozilla/WebKit
            }
        end,
    },
}
