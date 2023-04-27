local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "javascript",
        "java",
        "json",
        "lua",
        "python",
        "typescript",
        "tsx",
        "css",
        "rust",
        "java",
        "yaml",
        "toml",
        "html",
        "sql",
        "scala",
        "make",
        "haskell",
        "markdown",
        "markdown_inline",
        "org"
    }, -- one of "all" or a list of languages
	ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = {'org'}
	},
	autopairs = { enable = true },
	indent = { enable = true, disable = { "python", "css" } },
})
