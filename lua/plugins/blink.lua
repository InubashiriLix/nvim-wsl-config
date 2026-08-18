return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config

    opts = function(_, opts)
        opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
            preset = "super-tab",
            ["<Tab>"] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_and_accept()
                    end
                end,
                "snippet_forward",
                "fallback",
            },

            ["<S-Tab>"] = {
                "snippet_backward",
                "fallback",
            },

            ["<C-y>"] = {
                "select_and_accept",
                "fallback",
            },
        })

        opts.appearance = vim.tbl_deep_extend("force", opts.appearance or {}, {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        })

        -- (Default) Only show the documentation popup when manually triggered
        opts.completion = opts.completion or {}
        opts.completion.documentation = vim.tbl_deep_extend("force", opts.completion.documentation or {}, {
            auto_show = true,
            auto_show_delay_ms = 200,
        })

        opts.sources = opts.sources or {}
        opts.sources.providers = opts.sources.providers or {}

        opts.sources.default = { "lsp", "path", "snippets", "buffer" }
        opts.sources.min_keyword_length = 0

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        opts.fuzzy = { implementation = "prefer_rust_with_warning" }
    end,
}
