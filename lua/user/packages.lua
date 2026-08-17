-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Base
    { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
    { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter

    -- Quality of Life
    { "numToStr/Comment.nvim" },
    { "Pocco81/auto-save.nvim" },
    { "RRethy/vim-illuminate" },
    { "moll/vim-bbye" },
    { "ahmedkhalf/project.nvim" },

    -- LSP
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },
    { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },
    { "neovim/nvim-lspconfig" },
    { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },

    -- Debugging
    { "mfussenegger/nvim-dap" },
    { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
    { "Weissle/persistent-breakpoints.nvim", dependencies = { "mfussenegger/nvim-dap" } },

    -- Treesitter
    -- Pinned to master: the main branch is a rewrite that drops the
    -- nvim-treesitter.configs module this config uses.
    { "nvim-treesitter/nvim-treesitter", branch = "master", build = ":TSUpdate" },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

    -- Markdown
    { "MeanderingProgrammer/render-markdown.nvim", dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" } },

    -- Navigation
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "stevearc/oil.nvim" },

    -- Search
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

    -- Git
    { "lewis6991/gitsigns.nvim" },
    { "sindrets/diffview.nvim" },

    -- Colorschemes
    { "lunarvim/darkplus.nvim" },
    { "EdenEast/nightfox.nvim" },

    -- Shortcuts
    { "folke/which-key.nvim" },

    -- Personal Packages - will not install without ".personal" being present
    -- this is to avoid installing packages on company computers that might violate policies
    vim.fn.filereadable(vim.fn.expand("~/.config/nvim/.personal")) == 1 and {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
        end,
    } or nil,
}, {
    ui = {
        border = "rounded",
    },
    rocks = {
        enabled = false, -- no plugin here needs luarocks
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
