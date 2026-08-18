return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        format = {
                            enable = true,
                        },
                    },
                },
            },
        },
    },
}
