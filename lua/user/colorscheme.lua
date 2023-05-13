local colorscheme = "darkplus"
-- local colorscheme = "nightfox"
-- local colorscheme = "tokyonight"
-- local colorscheme = "carbonfox"
-- local colorscheme = "onedark"
-- local colorscheme = "nord"
-- local colorscheme = "material"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    return
end
