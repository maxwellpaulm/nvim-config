local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
    return
end

trouble.setup({
    keys = {
        -- Navigation to match the j→h, k→j, l→k, ;→l layout
        k = "next",
        l = "prev",
        ["<tab>"] = "jump",
    },
})
