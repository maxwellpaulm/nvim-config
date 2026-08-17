local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

which_key.setup({
    plugins = {
        presets = { operators = false },
    },
    win = {
        border = "rounded",
        padding = { 2, 2 },
    },
    -- hide mappings that carry no description of their own
    filter = function(mapping)
        return mapping.desc and mapping.desc ~= ""
    end,
})

which_key.add({
    {
        nowait = true,

        { "<leader>c", "<cmd>Bdelete!<cr>", desc = "Close Buffer" },
        { "<leader>f", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find files" },
        { "<leader>g", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Grep Project" },
        { "<leader>h", "<cmd>nohlsearch<cr>", desc = "No Highlight" },
        { "<leader>q", "<cmd>q!<cr>", desc = "Quit" },
        { "<leader>Q", "<cmd>qa!<cr>", desc = "Quit All" },
        { "<leader>w", "<cmd>vsplit<cr>", desc = "Vertical Split Window" },

        { "<leader>d", group = "Debugger" },
        { "<leader>dR", "<cmd>DapRestartFrame<cr>", desc = "Restart Frame" },
        { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
        { "<leader>dd", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
        { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
        { "<leader>dl", "<cmd>DapShowLog<cr>", desc = "Log" },
        { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step Over" },
        { "<leader>dr", "<cmd>DapToggleRepl<cr>", desc = "Repl" },
        { "<leader>ds", "<cmd>DapLoadLaunchJSON<cr>", desc = "Launch" },
        { "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Terminate" },
        { "<leader>du", "<cmd>DapStepOut<cr>", desc = "Step Out" },
        { "<leader>dU", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle UI" },
        { "<leader>de", "<cmd>lua require('dapui').eval()<cr>", desc = "Eval", mode = { "n", "v" } },

        { "<leader>N", group = "NeoVim" },
        { "<leader>Nk", "<cmd>Telescope keymaps<cr>", desc = "View keymappings" },
        { "<leader>Nl", "<cmd>Lazy<cr>", desc = "Lazy (plugins)" },
        { "<leader>Nm", "<cmd>Mason<cr>", desc = "Mason (LSP servers)" },

        { "<leader>G", group = "Git" },
        { "<leader>Gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage Hunk" },
        { "<leader>Gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset Hunk" },
        { "<leader>Gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview Hunk" },
        { "<leader>GS", "<cmd>lua require('gitsigns').stage_buffer()<cr>", desc = "Stage Buffer" },
        { "<leader>Gb", "<cmd>lua require('gitsigns').blame_line({ full = true })<cr>", desc = "Blame Line" },
        { "<leader>GB", "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>", desc = "Toggle Inline Blame" },
        { "<leader>Gd", "<cmd>DiffviewOpen<cr>", desc = "Diff Working Tree" },
        { "<leader>Gq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
        { "<leader>Gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
        { "<leader>GH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
        { "<leader>Gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
        { "<leader>Gf", "<cmd>Telescope git_bcommits<cr>", desc = "Buffer Commits" },
        { "<leader>Gt", "<cmd>Telescope git_status<cr>", desc = "Changed Files" },

        { "<leader>l", group = "LSP" },
        { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
        { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
        { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
        { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", desc = "Format" },
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
        { "<leader>lj", "<cmd>lua vim.diagnostic.jump{ count = 1, float = true }<cr>", desc = "Next Diagnostic" },
        { "<leader>lk", "<cmd>lua vim.diagnostic.jump{ count = -1, float = true }<cr>", desc = "Prev Diagnostic" },
        { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
        { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
        { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
        { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
        { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },

        { "<leader>s", group = "Search" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>sb", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Buffers" },
        { "<leader>sf", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
        { "<leader>sg", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
        { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },

        { "<leader>v", group = "Visual" },
        { "<leader>vw", "<cmd>set list!<cr>", desc = "Toggle Whitespace" },
        { "<leader>vi", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Guides" },
        { "<leader>vr", "<cmd>set relativenumber!<cr>", desc = "Toggle Relative Numbers" },
        { "<leader>vp", "<cmd>set wrap!<cr>", desc = "Toggle Wrap" },
        { "<leader>vs", "<cmd>set spell!<cr>", desc = "Toggle Spellcheck" },
        { "<leader>vd", "<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<cr>", desc = "Toggle Diagnostics" },

        { "<leader>x", group = "Trouble" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Loclist" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix" },
        { "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "References" },
        { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble" },
    },
})
