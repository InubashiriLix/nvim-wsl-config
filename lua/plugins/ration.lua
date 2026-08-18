return {
    dir = "/home/inubashiri/proj/neovim-plugin/ration.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = "cargo build --release -p ration-nvim",
    config = function()
        require("ration").setup(
            {
                language = "zh-CN",
                currency = "CNY",
            }
        )
    end,
}
