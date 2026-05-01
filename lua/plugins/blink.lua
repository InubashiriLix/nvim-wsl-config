local use_greek_completion = true

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
        opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, { preset = "super-tab" })

        opts.appearance = vim.tbl_deep_extend("force", opts.appearance or {}, {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        })

        -- (Default) Only show the documentation popup when manually triggered
        opts.completion = opts.completion or {}
        opts.completion.documentation = vim.tbl_deep_extend("force", opts.completion.documentation or {}, {
            auto_show = false,
        })

        opts.sources = opts.sources or {}
        opts.sources.default = opts.sources.default or {}
        opts.sources.providers = opts.sources.providers or {}

        for _, source in ipairs({ "lsp", "path", "snippets", "buffer" }) do
            if not vim.tbl_contains(opts.sources.default, source) then
                table.insert(opts.sources.default, source)
            end
        end

        if use_greek_completion then
            if not vim.tbl_contains(opts.sources.default, "greek") then
                table.insert(opts.sources.default, "greek")
            end
            opts.sources.providers.greek = {
                name = "Greek",
                module = "completion.greek",
                score_offset = -2,
                min_keyword_length = 1,
            }
        end

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        opts.fuzzy = { implementation = "prefer_rust_with_warning" }
    end,
    opts_extend = { "sources.default", "sources.providers" },
}
