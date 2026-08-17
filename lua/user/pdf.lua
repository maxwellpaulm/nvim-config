-- View PDFs as extracted text (requires poppler: brew install poppler)
-- For the real rendered layout, <leader>o opens the file in the system viewer.
vim.api.nvim_create_autocmd("BufReadCmd", {
    group = vim.api.nvim_create_augroup("user_pdf_view", { clear = true }),
    pattern = "*.pdf",
    callback = function(ev)
        if vim.fn.executable("pdftotext") == 0 then
            vim.notify("pdftotext not found (brew install poppler)", vim.log.levels.WARN)
            return
        end
        local lines = vim.fn.systemlist({ "pdftotext", "-layout", ev.file, "-" })
        vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)
        vim.bo[ev.buf].modified = false
        vim.bo[ev.buf].modifiable = false
        vim.bo[ev.buf].buftype = "nowrite"
        vim.bo[ev.buf].swapfile = false
    end,
})
