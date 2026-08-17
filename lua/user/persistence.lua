-- Persist display toggles (the <leader>v group) across sessions
local state_file = vim.fn.stdpath("data") .. "/display_prefs.json"
local options = { "list", "relativenumber", "wrap", "spell" }

local function load()
    local f = io.open(state_file, "r")
    if not f then
        return
    end
    local ok, prefs = pcall(vim.json.decode, f:read("*a"))
    f:close()
    if not ok or type(prefs) ~= "table" then
        return
    end
    for _, opt in ipairs(options) do
        if prefs[opt] ~= nil then
            vim.opt[opt] = prefs[opt]
        end
    end
end

local function save()
    local prefs = {}
    for _, opt in ipairs(options) do
        prefs[opt] = vim.o[opt]
    end
    local f = io.open(state_file, "w")
    if f then
        f:write(vim.json.encode(prefs))
        f:close()
    end
end

load()
vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("user_display_prefs", { clear = true }),
    callback = save,
})
