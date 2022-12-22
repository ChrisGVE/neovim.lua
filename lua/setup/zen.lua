require("zen-mode").setup({
	backdrop = 0.95, -- shade the backdrop of the Zen window
	width = 120, -- width of the Zen window
	height = 1, -- height of the Zen window
	plugins = {
		options = {
			enabled = true,
			ruler = false,
			showcmd = false,
		},
		twilight = { enabled = true },
		gitsigns = { enabled = false },
		tmux = { enabled = false },
		kitty = {
			enabled = false,
			font = "+4",
		},
	},
})
