local dap = require('dap')

get_rust_path = function()
    rust_paths = {
        "lldb-vscode",
        "lldb",
    }

    for _, path in ipairs(rust_paths) do
        local handle = io.popen('which ' .. path)
        local result = handle:read("*a")
        handle:close()
        if result ~= '' then
            return result:gsub('[\n\r]', '')
        end
    end

    vim.notify("[nvim-dap-debugger] Could not find lldb debugger", vim.log.levels.ERROR, nil)
    return nil
end

dap.adapters.lldb = {
    type = 'executable',
    command = get_rust_path(),
    name = 'lldb'
}
