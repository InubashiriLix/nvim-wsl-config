return {
    "neovim/nvim-lspconfig",
    opts = {
        diagnostics = {
            underline = false,
        },
        servers = {
            teal_ls = {
                mason = false,
                cmd = { vim.fn.expand("~/.luarocks/bin/teal-language-server") },
                handlers = {
                    ["textDocument/signatureHelp"] = function(err, result, ctx, config)
                        if result and result.signatures then
                            result.signatures = vim.tbl_filter(function(signature)
                                return type(signature.label) == "string" and signature.label ~= ""
                            end, result.signatures)

                            if #result.signatures == 0 then
                                result = nil
                            end
                        end

                        return vim.lsp.handlers["textDocument/signatureHelp"](err, result, ctx, config)
                    end,
                },
            },
        },
    },
}
