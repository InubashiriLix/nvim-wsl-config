return
{
    dir = "/home/inubashiri/proj/neovim-plugin/Ielts.nvim/",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
        locale = "zh_CN",
        player = {
            command = "mpv",
            speeds = { 0.75, 1.0, 1.2, 1.5, 2.0 },
            seek_seconds = 5,
        },
    },
}
