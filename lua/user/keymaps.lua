local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = function(modes, orig, mapped, opts)
    for m in modes:gmatch"." do
        vim.api.nvim_set_keymap(m, orig, mapped, opts)
    end
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- normal navigation
keymap("nv", "j", "h", opts)
keymap("nv", "k", "j", opts)
keymap("nv", "l", "k", opts)
keymap("nv", ";", "l", opts)

-- super navigation
keymap("nv", "sk", "<C-d>", opts)
keymap("nv", "sl", "<C-u>", opts)
keymap("nv", "s;", "$", opts)
keymap("nv", "sj", "^", opts)

-- delete shortcuts
keymap("n", "d;", "d$", opts)
keymap("n", "dj", "d^", opts)

-- tab and window navigation --
keymap("n", "cc", ":BufferPrevious<cr>", opts)
keymap("n", "vv", ":BufferNext<cr>", opts)
keymap("n", "fj", "<C-w>h", opts)
keymap("n", "f;", "<C-w>l", opts)
keymap("n", "fk", "<C-w>k", opts)
keymap("n", "fl", "<C-w>j", opts)
keymap("n", "ff", "<cmd>NvimTreeFocus<cr>", opts)
keymap("n", "ft", "<cmd>NvimTreeToggle<cr>", opts)
keymap("n", "fv", "<cmd>vsplit<cr>", opts)
keymap("n", "g;", "<C-i>", opts)
keymap("n", "gj", "<C-o>", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Press jk fast to exit insert mode
keymap("i", "lk", "<ESC>", opts)
keymap("i", "kl", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

