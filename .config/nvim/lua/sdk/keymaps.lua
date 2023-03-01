local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.maplocalleader = ";"

-- Better move around
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate Buffers
vim.api.nvim_command("nnoremap <leader>b   :b <C-d>")
vim.keymap.set("n", "<S-l>", vim.cmd.bnext, opts)
vim.keymap.set("n", "<S-h>", vim.cmd.bprevious, opts)

-- Other
vim.keymap.set("v", "p", '"_dP', opts) -- better paste
vim.keymap.set('n', 'db', 'vb"_d', opts) -- delete a word backward.
vim.keymap.set("v", ">", ">gv", opts) -- increase indentation
vim.keymap.set("v", "<", "<gv", opts) -- decrease indentation
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts) -- move text up
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts) -- move text down
vim.keymap.set("n", "<leader>.", vim.cmd.Ex, opts) -- File Explorer
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts) -- formatting
vim.keymap.set("n", "<leader>ex", "<cmd>!chmod +x %<CR>", opts) -- make scripts executable
vim.keymap.set("n", "<C-r>", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts) -- Search & Replace
vim.keymap.set("n", "<leader>h", vim.cmd.nohlsearch, opts)

------------------ Plugins -------------------
-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", opts)

-- Git
vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Neorg presenter
vim.keymap.set("n", "<leader>ps", ":Neorg presenter start<CR>", opts)
vim.keymap.set("n", "<leader>pe", ":Neorg presenter close<CR>", opts)
