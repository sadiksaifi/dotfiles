-- For transparency
vim.cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
vim.cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
vim.cmd "let &fcs='eob: '"

local colorscheme = "rose-pine"

local status_ok, rose_pine = pcall(require, "rose-pine")
if not status_ok then
  return
end

rose_pine.setup({
	--- @usage 'auto'|'main'|'moon'|'dawn'
	variant = 'moon',
	--- @usage 'main'|'moon'|'dawn'
	dark_variant = 'moon',
	bold_vert_split = false,
	dim_nc_background = false,
	disable_background = true,
	disable_float_background = true,
	disable_italics = false,

	--- @usage string hex value or named color from rosepinetheme.com/palette
	groups = {
		background = 'base',
		background_nc = '_experimental_nc',
		panel = 'surface',
		panel_nc = 'base',
		border = 'highlight_med',
		comment = 'muted',
		link = 'iris',
		punctuation = 'subtle',

		error = 'love',
		hint = 'iris',
		info = 'foam',
		warn = 'gold',

		headings = {
			h1 = 'iris',
			h2 = 'foam',
			h3 = 'rose',
			h4 = 'gold',
			h5 = 'pine',
			h6 = 'foam',
		}
		-- or set all headings at once
		-- headings = 'subtle'
	},

	-- Change specific vim highlight groups
	-- https://github.com/rose-pine/neovim/wiki/Recipes
	highlight_groups = {
		ColorColumn = { bg = 'rose' },

		-- Blend colours against the "base" background
		CursorLine = { bg = 'foam', blend = 10 },
		StatusLine = { fg = 'love', bg = 'love', blend = 10 },
	}
})

-- Settings colorscheme
local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  return
end
