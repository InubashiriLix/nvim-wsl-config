return {
    {
        "yianwillis/vimcdoc",
        lazy = false,

        init = function()
            -- 优先中文，找不到中文文档时回退英文
            vim.opt.helplang = { "cn", "en" }
        end,
    },
}
