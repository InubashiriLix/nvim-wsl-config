-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- set 'jk', 'jj', 'kk', 'kj' to exit insert mode
vim.keymap.set("i", "<Esc>", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "kk", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })
vim.keymap.set("i", "kj", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })

-- vim.keymap.set("n", "<leader>ai", "<cmd>sidekick cli toggle<CR>", { desc = "Sidekick Toggle" })
vim.keymap.set("n", "<leader>aso", function()
    vim.cmd("Sidekick nes enable")
    vim.notify("Sidekick NES enabled", vim.log.levels.INFO, {
        title = "Sidekick",
        icon = "🤖",
    })
end, { desc = "Sidekick NES Enable" })

vim.keymap.set("n", "<leader>asd", function()
    vim.cmd("Sidekick nes disable")
    vim.notify("Sidekick NES disabled", vim.log.levels.INFO, {
        title = "Sidekick",
        icon = "🛑",
    })
end, { desc = "Sidekick NES Disable" })

-- enable and disable theme (I use tokyonight now) transparent

vim.keymap.set("n", "<leader>uu", function()
    local current_state = vim.g.toggle_tokyonight_transparent()
    vim.cmd("colorscheme tokyonight") -- update the colorscheme to apply the change
    vim.notify("Tokyonight transparent mode" .. (current_state and " enabled" or " disabled"), vim.log.levels.INFO, {
        title = "Tokyonight Theme",
        icon = "🎨",
    })
end, { desc = "Toggle Tokyonight Theme" })

vim.keymap.set("n", "<leader><F5>", function()
    -- find is current dir contains any CMakeLists.txt file
    local handle = io.popen("find . -maxdepth 3 -name 'CMakeLists.txt'")
    -- if have, then can run the CMakeBuild Command
    if handle:read("*a") ~= "" then
        vim.cmd("CMakeBuild")
        vim.notify("CMake Build executed", vim.log.levels.INFO, {
            title = "CMake",
            icon = "🛠️",
        })
    else
        vim.notify("No CMakeLists.txt found in current directory", vim.log.levels.WARN, {
            title = "CMake-Tools",
            icon = "⚠️",
        })
    end
end, { desc = "CMakeRun Current Proj" })

vim.keymap.set("n", "<leader><F6>", function()
    -- find is current dir contains any CMakeLists.txt file
    local handle = io.popen("find . -maxdepth 3 -name 'CMakeLists.txt'")
    -- if have, then can run the CMakeBuild Command
    if handle:read("*a") ~= "" then
        vim.cmd("CMakeRun")
    else
        vim.notify("No CMakeLists.txt found in current directory", vim.log.levels.WARN, {
            title = "CMake-Tools",
            icon = "⚠️",
        })
    end
end, { desc = "CMakeRun Current Proj" })

vim.keymap.set("n", "<leader><F7>", function()
    -- find is current dir contains any CMakeLists.txt file
    local handle = io.popen("find . -maxdepth 3 -name 'CMakeLists.txt'")
    -- if have, then can run the CMakeBuild Command
    if handle:read("*a") ~= "" then
        vim.cmd("CMakeRunCurrentFile")
    else
        vim.notify("No CMakeLists.txt found in current directory", vim.log.levels.WARN, {
            title = "CMake-Tools",
            icon = "⚠️",
        })
    end
end, { desc = "CMake Close Executor" })

-- Leave terminal-mode so the terminal buffer can be navigated like a normal buffer.
vim.keymap.set("t", "<C-q>", "<cmd>stopinsert<cr>", { desc = "Terminal Normal Mode" })

-- kill all the marks
vim.keymap.set("n", "<leader>md", function()
    vim.cmd("delmarks!")
    vim.cmd("delmarks A-Z0-9")
    vim.cmd("wshada!")
end, { desc = "Delete all marks" })

-- FUCK F1
vim.keymap.set({ "n", "i", "v" }, "<F1>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>cb",
    function()
        require("blink.cmp").reload()
        vim.notify('blink.cmp reloaded')
    end,
    { desc = "Reload blink.nvim cmp" }
)

vim.keymap.set("n", "<leader><F1><F1>", "<cmd>AmbientToggle<CR>", { desc = "Ambient Toggle", icon = "🎵+" })
vim.keymap.set("n", "<leader><F1>j", "<cmd>AmbientNext<CR>", { desc = "Ambient Next", icon = "⏭️" })
vim.keymap.set("n", "<leader><F1>k", "<cmd>AmbientStop<CR>", { desc = "Ambient Stop", icon = "⏹️" })
vim.keymap.set("n", "<leader><F1>l", "<cmd>AmbientProgressToggle<CR>", { desc = "Ambient Progress Toggle", icon = "📊" })
