-- Set keys to navigate whilst being in terminal mode
function _G.set_terminal_keymaps()
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = 0, desc = 'C-\\ C-n' })
	vim.keymap.set("t", "ij", [[<C-\><C-n>]], { buffer = 0, desc = 'C-\\ C-n' })
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<cr>]], { buffer = 0, desc = "Window left" })
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<cr>]], { buffer = 0, desc = "Window down" })
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<cr>]], { buffer = 0, desc = "Window up" })
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<cr>]], { buffer = 0, desc = "Window right" })
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- This comes from tjdevries config manager and is used for telescope-hop
P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end

-- Setup for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
