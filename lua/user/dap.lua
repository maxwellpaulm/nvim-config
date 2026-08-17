local status_ok, dap = pcall(require, "dap")
if not status_ok then
    return
end

-- Inline variable values while debugging
local status_ok_vt, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if status_ok_vt then
    dap_virtual_text.setup({})
end

-- Debugger UI (scopes, watches, stack, breakpoints)
local status_ok_ui, dapui = pcall(require, "dapui")
if status_ok_ui then
    dapui.setup({})

    -- Open the UI when a session starts, close it when it ends
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

-- DAP Python
-- https://github.com/mfussenegger/nvim-dap-python
local status_ok_py, python = pcall(require, "dap-python")
if status_ok_py then
    python.setup("~/.virtualenvs/debugpy/bin/python")
end
