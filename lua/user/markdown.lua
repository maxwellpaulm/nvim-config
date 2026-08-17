local status_ok, render_markdown = pcall(require, "render-markdown")
if not status_ok then
    return
end

render_markdown.setup({
    -- Render in normal mode, show raw markdown while editing the line
    render_modes = { "n", "c", "t" },
})
