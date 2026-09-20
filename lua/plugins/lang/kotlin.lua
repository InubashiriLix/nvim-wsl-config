local root_markers = {
    "settings.gradle.kts",
    "settings.gradle",
    "build.gradle.kts",
    "build.gradle",
    ".git",
}

local function read_file(path)
    local file = io.open(path, "r")
    if not file then
        return ""
    end

    local content = file:read("*a")
    file:close()
    return content
end

local function project_kind(bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(filename, { "settings.gradle.kts", "settings.gradle" })
        or vim.fs.root(filename, root_markers)

    if not root then
        return nil, false
    end

    -- KMP source-set names are decisive even when the plugin is supplied by a
    -- convention plugin and is therefore absent from the module build script.
    local normalized = filename:gsub("\\", "/")
    if normalized:match("/src/[%w]+Main/") or normalized:match("/src/[%w]+Test/") then
        if not normalized:match("/src/main/") and not normalized:match("/src/test/") then
            return root, true
        end
    end

    -- Inspect build scripts from the current module up to the Gradle root.
    -- This covers direct plugin declarations and common version-catalog aliases.
    local dir = vim.fs.dirname(filename)
    while dir do
        local build = read_file(dir .. "/build.gradle.kts") .. "\n" .. read_file(dir .. "/build.gradle")
        if build:match('kotlin%s*%(%s*["\']multiplatform["\']%s*%)')
            or build:match('org%.jetbrains%.kotlin%.multiplatform')
            or build:match('[Kk]otlin[%._%-]?[Mm]ultiplatform')
        then
            return root, true
        end

        if dir == root then
            break
        end

        local parent = vim.fs.dirname(dir)
        if not parent or parent == dir then
            break
        end
        dir = parent
    end

    return root, false
end

local function root_for(kmp)
    return function(bufnr, on_dir)
        local root, is_kmp = project_kind(bufnr)
        if root and is_kmp == kmp then
            on_dir(root)
        end
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                -- Keep fwcd's server out of the selection entirely.
                kotlin_language_server = { enabled = false },

                -- JetBrains' server for regular JVM/Android Kotlin projects.
                kotlin_lsp = {
                    mason = false,
                    cmd = { "intellij-server", "--stdio" },
                    root_dir = root_for(false),
                },

                -- KMP-aware server, attached only when the project is actually KMP.
                kmp_lsp = {
                    mason = false,
                    cmd = { "kmp-lsp" },
                    filetypes = { "kotlin" },
                    root_dir = root_for(true),
                    settings = {},
                },
            },
        },
    },
}
