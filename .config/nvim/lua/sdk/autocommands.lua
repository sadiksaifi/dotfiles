vim.api.nvim_create_autocmd( "FileType" , {
	pattern = { "*.md", "*.tex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})
