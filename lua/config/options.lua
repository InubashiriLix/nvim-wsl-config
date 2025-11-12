-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- setup the clipboard for WSL
vim.o["clipboard"] = "unnamedplus"

vim.g.clipboard = {
  name = "win32yank-wsl",
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
  cache_enable = 0,
}

vim.opt.tabstop = 4 -- Tab 显示为 4 个空格
vim.opt.shiftwidth = 4 -- 自动缩进为 4 个空格
vim.opt.expandtab = true -- 将 Tab 转换为空格
vim.opt.softtabstop = 4 -- 输入 Tab 键时插入 4 个空格
