local M = {}
local config_state = {}
local config_window = nil
local config_buffer = nil
local curved = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }


function M._get_float_config(opts, opening)
    local border = opts.border == "curved" and curved or opts.border or "single"
    local width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
    local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))
    local row = math.ceil(vim.o.lines - height) * 0.5 - 1
    local col = math.ceil(vim.o.columns - width) * 0.5 - 1

    return {
        row = row,
        col = col,
        relative = opts.relative or "editor",
        style = opening and "minimal" or nil,
        width = width,
        height = height,
        border = opening and border or nil,
        zindex = opts.zindex or nil,
    }
end

function M._open_window()
    vim.notify("[nvim-debug-config] Opening the debug config windw", vim.log.levels.DEBUG, nil)
    origin_window = vim.api.nvim_get_current_win()
    config_buffer = vim.api.nvim_create_buf(false, true)
    local opts = {border = "curved"}
    local config_window = vim.api.nvim_open_win(config_buffer, true, M._get_float_config(opts, true))
    vim.api.nvim_set_current_win(config_window)
    vim.api.nvim_buf_set_text(config_buffer, 0, 0, 0, 0, {"test", "test"})
end

function M._close_window()
    vim.notify("[nvim-debug-config] Closing the debug config window", vim.log.levels.DEBUG, nil)
    if origin_window and vim.api.nvim_win_is_valid(origin_window) then
        vim.api.nvim_win_close(origin_window, true)
        origin_window = nil
    end
end

function M.toggle_debug_config()
    vim.notify("[nvim-debug-config] Opening the debug config", vim.log.levels.INFO, nil)
    -- if origin_window and vim.api.nvim_win_is_valid(origin_window) then
        -- M._close_window()
    -- else
        M._open_window()
    -- end
end

return M

