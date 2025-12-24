-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- NOTE: sidekick CLI toogle for sidekick.nvim
-- vim.keymap.set({ "n", "i", "x", "t" }, "<leader>ai", function()
--     require("sidekick.cli").toggle()
-- end, { desc = "Sidekick Toggle (no Ctrl)" })

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

vim.keymap.set("n", "<leader>u", function()
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
        vim.cmd("CMakeCloseExecutor")
    else
        vim.notify("No CMakeLists.txt found in current directory", vim.log.levels.WARN, {
            title = "CMake-Tools",
            icon = "⚠️",
        })
    end
end, { desc = "CMake Close Executor" })
