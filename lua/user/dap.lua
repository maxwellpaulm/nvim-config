local status_ok, dap = pcall(require, "dap")
if not status_ok then
    return
end

-- Debug signs: highlight the executing line with a warm tone
local function set_dap_highlights()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#4a3f2a" })
end
set_dap_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("user_dap_highlights", { clear = true }),
    callback = set_dap_highlights,
})

vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn", linehl = "DapStoppedLine", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticSignHint" })

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

-- Persist breakpoints across sessions (saved per project directory)
local status_ok_pb, persistent_breakpoints = pcall(require, "persistent-breakpoints")
if status_ok_pb then
    persistent_breakpoints.setup({
        load_breakpoints_event = { "BufReadPost" },
    })
end

-- DAP Python
-- https://github.com/mfussenegger/nvim-dap-python
local status_ok_py, python = pcall(require, "dap-python")
if status_ok_py then
    python.setup("~/.virtualenvs/debugpy/bin/python")
end

-- DAP Go (delve)
-- https://github.com/leoluz/nvim-dap-go
local status_ok_go, dap_go = pcall(require, "dap-go")
if status_ok_go then
    -- dlv lives in ~/go/bin, which is not always on PATH
    local dlv = vim.fn.exepath("dlv")
    if dlv == "" then
        dlv = vim.fn.expand("~/go/bin/dlv")
    end
    dap_go.setup({
        delve = { path = dlv },
    })
end
