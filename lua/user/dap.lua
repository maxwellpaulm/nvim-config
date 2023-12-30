-- DAP API
-- Nothing

-- DAP Python
-- https://github.com/mfussenegger/nvim-dap-python
local status_ok, python = pcall(require, "dap-python")
if not status_ok then
  return
end
python.setup('~/.virtualenvs/debugpy/bin/python')

