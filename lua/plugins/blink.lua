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
        opts.keymap = { preset = "super-tab" }

        opts.appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        }

        -- (Default) Only show the documentation popup when manually triggered
        opts.completion = { documentation = { auto_show = false } }

        opts.sources = {
            -- default = { "lsp", "path", "snippets", "buffer", "greek" },
            default = { "lsp", "path", "snippets", "buffer" },
            -- providers = {
            -- greek = {
            --     name = "Greek",
            --     module = "completion.greek",
            --     score_offset = -2,
            --     min_keyword_length = 1,
            -- },
            -- },
        }

        if use_greek_completion then
            opts.sources.default = vim.list_extend(opts.sources.default, { "greek" })
            opts.sources.providers =
                { greek = { name = "Greek", module = "completion.greek", score_offset = -2, min_keyword_length = 1 } }
        end

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        opts.fuzzy = { implementation = "prefer_rust_with_warning" }
    end,
    opts_extend = { "sources.default" },
}
