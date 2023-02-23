local treesitter = require("nvim-treesitter")
local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = { "help", "lua", "markdown", "latex", "bash", "python", "cpp", "c", "java", "javascript", "typescript", "tsx", "html", "css" }, -- put the language you want in this array
	-- ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
	},
})
