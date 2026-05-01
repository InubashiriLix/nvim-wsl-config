return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                clangd = {
                    mason = true,
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        -- "--function-arg-placeholders=true",
                        "--fallback-style=llvm",
                        -- "--query-driver=/home/inubashiri/.espressif/tools/**/riscv32-esp-elf-gcc,/home/inubashiri/.espressif/tools/**/xtensa-esp-elf-gcc",
                    },
                    cmd_env = {
                        LC_ALL = "C",
                        LANG = "C",
                    },
                    init_options = {
                        usePlaceholders = true,
                        completeUnimported = true,
                        clangdFileStatus = true,
                    },
                },
            },
        },
    },
    {
        "p00f/clangd_extensions.nvim",
        lazy = true,
        config = function() end,
        opts = {
            inlay_hints = {
                inline = false,
            },
            ast = {
                --These require codicons (https://github.com/microsoft/vscode-codicons)
                role_icons = {
                    type = "",
                    declaration = "",
                    expression = "",
                    specifier = "",
                    statement = "",
                    ["template argument"] = "",
                },
                kind_icons = {
                    Compound = "",
                    Recovery = "",
                    TranslationUnit = "",
                    PackExpansion = "",
                    TemplateTypeParm = "",
                    TemplateTemplateParm = "",
                    TemplateParamObject = "",
                },
            },
        },
    },
}
