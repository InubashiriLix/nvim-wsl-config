return {
    "neovim/nvim-lspconfig",
    opts = {
        diagnostics = {
            underline = false,
        },
        servers = {
            -- =======================================================
            -- ======================== CPP ==========================
            -- =======================================================
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
}
