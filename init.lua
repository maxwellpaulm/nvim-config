-- Load options first to set up vim environment
require "user.options"

-- Load package manager and plugins
require "user.packages"

-- Load plugin configurations
require "user.colorscheme"
require "user.comment"
require "user.illuminate"
require "user.indentline"
require "user.trouble"
require "user.lualine"
require "user.nvim-tree"
require "user.oil"
require "user.telescope"
require "user.treesitter"
require "user.whichkey"
require "user.autosave"
require "user.dap"
require "user.gitsigns"
require "user.markdown"

-- Load LSP and completion
require "user.lsp"
require "user.cmp"

-- Load keymaps last so they can override plugin defaults
require "user.keymaps"

vim.opt.list = true
vim.opt.listchars = {
  tab = "⇥ ",
  trail = "•",
  space = "·",
  eol = "↩",
}

vim.opt.foldenable = true
vim.opt.foldlevel = 99        -- ensures everything starts unfolded
vim.opt.foldcolumn = "1"      -- shows fold markers in the gutter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
