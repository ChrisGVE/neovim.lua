require("twilight").setup({
	dimming = {
		alpha = 0.25, -- amount of dimming
		color = { "Normal", "#ffffff" },
		term_bg = "#000000", -- if guibg=NONE this will be used to calculate text color
		inactive = false, -- wehn true, other windows will be fully dimmed (unless they contain the same buffer)
	},
	context = 10, -- amount of lines we will try  to show around the current line
	treesitter = true, -- use treesitter when available for the fieltype
	expand = { -- for treesitter, we always try to expand to the top-most ancestor with these type
		"function",
		"method",
		"table",
		"if_statement",
	},
	exclude = {}, -- exclude these file types
})
