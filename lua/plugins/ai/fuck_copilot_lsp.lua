-- NOTE:
-- note: only for `copilot-language-lsp`
-- To be honest, sometimes, its suggestion can be a little useful (better than none)
-- BUT IT WILL FUCKING CONSUME 800MB - 1000MB memory.
-- AND EACH FUCKING NVIM INSTANCE WILL HOLD A BRAND NEW COPILOT MOTHERFUCKING LSP INSTANCE SEPARATELY
-- It's wasting my ram, life and my fucking love for neovim in a pitty and insane way
-- So I'm going to FUCK THIS SHIT.
--
---(sidekick issue #231)[https://github.com/folke/sidekick.nvim/issues/231]

return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            copilot = {
                enabled = false,
            },
        },
    },
}

-- FUCK YOU COPILOT LSP!!!! FUCK YOU!!!
