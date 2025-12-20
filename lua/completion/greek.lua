local Kind = require("blink.cmp.types").CompletionItemKind
local InsertTextFormat = vim.lsp.protocol.InsertTextFormat

local greek_letters = {
    { name = "alpha", lower = "α", upper = "Α" },
    { name = "beta", lower = "β", upper = "Β" },
    { name = "gamma", lower = "γ", upper = "Γ" },
    { name = "delta", lower = "δ", upper = "Δ" },
    { name = "epsilon", lower = "ε", upper = "Ε" },
    { name = "zeta", lower = "ζ", upper = "Ζ" },
    { name = "eta", lower = "η", upper = "Η" },
    { name = "theta", lower = "θ", upper = "Θ" },
    { name = "iota", lower = "ι", upper = "Ι" },
    { name = "kappa", lower = "κ", upper = "Κ" },
    { name = "lambda", lower = "λ", upper = "Λ" },
    { name = "mu", lower = "μ", upper = "Μ" },
    { name = "nu", lower = "ν", upper = "Ν" },
    { name = "xi", lower = "ξ", upper = "Ξ" },
    { name = "omicron", lower = "ο", upper = "Ο" },
    { name = "pi", lower = "π", upper = "Π" },
    { name = "rho", lower = "ρ", upper = "Ρ" },
    { name = "sigma", lower = "σ", upper = "Σ" },
    { name = "sigma_final", lower = "ς", description = "final sigma" },
    { name = "tau", lower = "τ", upper = "Τ" },
    { name = "upsilon", lower = "υ", upper = "Υ" },
    { name = "phi", lower = "φ", upper = "Φ" },
    { name = "chi", lower = "χ", upper = "Χ" },
    { name = "psi", lower = "ψ", upper = "Ψ" },
    { name = "omega", lower = "ω", upper = "Ω" },
}

local function add_item(items, letter, glyph, case_label)
    local display_name = letter.name:gsub("_", " ")
    local suffix = letter.description and string.format(" (%s)", letter.description) or ""

    table.insert(items, {
        label = glyph,
        filterText = display_name,
        insertText = glyph,
        detail = string.format("%s %s%s", display_name, case_label, suffix),
        documentation = {
            kind = "plaintext",
            value = string.format("Greek %s %s%s (%s)", case_label, display_name, suffix, glyph),
        },
        kind = Kind.Text,
        insertTextFormat = InsertTextFormat.PlainText,
    })
end

local function build_items(opts)
    local items = {}
    for _, letter in ipairs(greek_letters) do
        if opts.include_lowercase and letter.lower then
            add_item(items, letter, letter.lower, "lowercase")
        end
        if opts.include_uppercase and letter.upper then
            add_item(items, letter, letter.upper, "uppercase")
        end
    end
    return items
end

local Source = {}

function Source.new(opts)
    opts = vim.tbl_deep_extend("force", {
        include_lowercase = true,
        include_uppercase = true,
    }, opts or {})

    local self = setmetatable({}, { __index = Source })
    self.items = build_items(opts)

    return self
end

function Source:get_completions(_, callback)
    callback({
        is_incomplete_forward = false,
        is_incomplete_backward = false,
        items = self.items,
    })
end

return Source
