local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
    return
end

gitsigns.setup({
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
    },
    current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
    },
    preview_config = {
        border = "rounded",
    },
    on_attach = function(bufnr)
        local opts = { buffer = bufnr, silent = true }

        -- Hunk navigation (falls back to diff-mode ]c/[c in diff buffers)
        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, vim.tbl_extend("force", opts, { desc = "Next hunk" }))

        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, vim.tbl_extend("force", opts, { desc = "Previous hunk" }))
    end,
})
