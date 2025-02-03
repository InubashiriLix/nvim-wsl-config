local null_ls = require("null-ls")
return {
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.prettier.with({
        extra_args = { "--tab-width", "4" },
      }),
      null_ls.builtins.formatting.stylua.with({
        extra_args = { "--indent-width", "4" },
      }),
    },
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end, { desc = "Format current buffer with LSP" })
      end
    end,
  }),
}
