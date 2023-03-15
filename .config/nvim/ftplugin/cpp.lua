vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.cpp" },
	callback = function()
		vim.api.nvim_command("!g++ % -o %:r.out")
		-- vim.api.nvim_command("silent !g++ % -o %:p")
	end,
})
