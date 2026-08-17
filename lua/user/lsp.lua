-- LSP Configuration (native vim.lsp, servers installed via mason)
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

-- Capabilities for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
local status_ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end
vim.lsp.config("*", { capabilities = capabilities })

-- Server-specific settings (base configs come from nvim-lspconfig)
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

local ts_inlay_hints = {
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = true,
    includeInlayPropertyDeclarationTypeHints = true,
    includeInlayFunctionLikeReturnTypeHints = true,
    includeInlayEnumMemberValueHints = true,
}
vim.lsp.config("ts_ls", {
    settings = {
        typescript = { inlayHints = ts_inlay_hints },
        javascript = { inlayHints = ts_inlay_hints },
    },
})

vim.lsp.config("pyright", {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

-- Install servers; mason-lspconfig enables installed servers automatically
mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",           -- Lua
        "gopls",            -- Go
        "ts_ls",            -- TypeScript/JavaScript
        "pyright",          -- Python
        "rust_analyzer",    -- Rust
        "jsonls",           -- JSON
        "yamlls",           -- YAML
        "bashls",           -- Bash
        "html",             -- HTML
        "cssls",            -- CSS
    },
})

-- Buffer-local keymaps and highlight when an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local opts = { noremap = true, silent = true, buffer = event.buf }

        -- Navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

        -- Documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

        -- Diagnostics
        vim.keymap.set("n", "[g", function() vim.diagnostic.jump({ count = -1 }) end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
        vim.keymap.set("n", "]g", function() vim.diagnostic.jump({ count = 1 }) end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

        -- Highlight symbol under cursor
        if client and client:supports_method("textDocument/documentHighlight") then
            local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = event.buf, group = group })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = group,
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                group = group,
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

-- Configure diagnostic display
vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})
