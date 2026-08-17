local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local function on_attach(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)

    local opts = { buffer = bufnr, noremap = true, silent = true, nowait = true }
    -- Custom navigation to match the j→h, k→j, l→k, ;→l layout
    vim.keymap.set("n", ";", api.node.open.edit, opts)
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts)
    vim.keymap.set("n", "o", api.node.open.edit, opts)
    vim.keymap.set("n", "f", api.node.open.edit, opts)
    vim.keymap.set("n", "j", api.node.navigate.parent_close, opts)
    vim.keymap.set("n", "v", api.node.open.vertical, opts)
end

nvim_tree.setup {
    on_attach = on_attach,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    renderer = {
        root_folder_label = ":t",
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 30,
        side = "left",
    },
}
