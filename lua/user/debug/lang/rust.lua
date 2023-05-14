local dap = require('dap')
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    -- command = '$(which lldb-vscode)', -- adjust as needed, must be absolute path
    name = 'lldb'
}
