local status_ok, render_markdown = pcall(require, "render-markdown")
if not status_ok then
    return
end

render_markdown.setup({
    heading = {
        position = "inline", -- keep the heading text in place, icon in front
        border = true,       -- blank line band above/below each heading
    },
    code = {
        border = "thick",
    },
    pipe_table = {
        preset = "round", -- rounded corners on table borders
    },
})
