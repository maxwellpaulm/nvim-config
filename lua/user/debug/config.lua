if not pcall(require, "dap") then
    vim.notify("[nvim-dap-projects] Could not find nvim-dap, make sure you load it before nvim-dap-projects.", "error")
    return
end


local M = {}

function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')
    for filename in pfile:lines() do
        if filename ~= "." and filename ~= ".." then
            i = i + 1
            t[i] = filename
        end
    end
    pfile:close()
    return t
end

function M.list_configs()
    local project_configs = {}
    local nvim_config_files = scandir("./.nvim")
    for _, filename in ipairs(nvim_config_files) do
        relative_path = "./.nvim/" .. filename
        if string.find(relative_path, ".lua") == nil then goto continue end

        local f = io.open(relative_path)
        if f ~= nil then
            f:close()

            -- add the filename without the extension to the list of configs
            project_configs[#project_configs+1] = require('string').sub(filename, 1, -5)
        end
        ::continue::
    end

    vim.notify("[nvim-dap-projects] Found " .. #project_configs .. " project configurations.", "debug")
    return project_configs
end

vim.debug_config = {}

function M._get_float_config(opts, opening)
    vim.api.nvim_set_hl(0,'TRed', {fg="#b52828"})
    local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    local width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 40)))
    local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 30)))
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
        title = 'Debug Config',
        title_pos = 'center',
    }
end

function M._open_window()
    vim.debug_config.project_config_files = M.list_configs()
    local config_buffer = vim.api.nvim_create_buf(false, true)
    vim.debug_config.config_window = vim.api.nvim_open_win(config_buffer, true, M._get_float_config({}, true))
    vim.api.nvim_set_current_win(vim.debug_config.config_window)
    vim.api.nvim_buf_set_text(config_buffer, 0, 0, 0, 0, vim.debug_config.project_config_files)
end

function M._close_window()
    if vim.debug_config.config_window and vim.api.nvim_win_is_valid(vim.debug_config.config_window) then
        vim.api.nvim_win_close(vim.debug_config.config_window, true)
        vim.debug_config.config_window = nil
    end
end

function M.toggle_debug_config()
    if vim.debug_config.config_window and vim.api.nvim_win_is_valid(vim.debug_config.config_window) then
        M._close_window()
    else
        M._open_window()
    end
end


function M.select_config(config_name)
    M._close_window()
    vim.debug_config.selected_config_name = config_name
    vim.notify("[nvim-dap-projects] Selected config: " .. config_name, "debug")
    require('dap').adapters = (function() return {} end)()
    require('dap').configurations = (function() return {} end)()
    vim.cmd(":luafile ./.nvim/" .. config_name .. ".lua")
end


return M

