return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                -- fwcd/kotlin-language-server cannot import this project's Kotlin 2.4
                -- + AGP 9 KMP Android source-set model correctly.
                kotlin_language_server = { enabled = false },

                -- JetBrains' server still does not support KMP project import.
                kotlin_lsp = { enabled = false },

                -- Native KMP-aware server. Semantic correctness remains covered by
                -- Gradle; this server provides navigation/completion without bogus
                -- unresolved-reference diagnostics for Compose source sets.
                kmp_lsp = {
                    mason = false,
                    cmd = { "kmp-lsp" },
                    filetypes = { "kotlin" },
                    root_markers = {
                        "settings.gradle.kts",
                        "settings.gradle",
                        "build.gradle.kts",
                        "build.gradle",
                        ".git",
                    },
                    settings = {},
                },
            },
        },
    },
}
