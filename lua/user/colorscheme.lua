local colorscheme = "darkplus"
-- local colorscheme = "carbonfox"
-- local colorscheme = 'onedark'
-- local colorscheme = "zenbones"
-- local colorscheme = "noctis"

-- local colorscheme = "onedark"
-- require('onedark').setup {style = 'warmer'}
require('onedark').setup {style = 'darker'}
require('onedark').load()

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    return
end
