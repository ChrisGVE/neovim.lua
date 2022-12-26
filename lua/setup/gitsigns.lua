require("gitsigns").setup({

	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	},

	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},

	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`

	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},

	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)

	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},

	yadm = {
		enable = false,
	},

	on_attach = function(bufnr)
		local wk = require("which-key")
		local gs = package.loaded.gitsigns

		-- Actions
		wk.register({
			mode = "n",
			buffer = bufnr,
			["]c"] = {
				function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end,
				"Git: next hunk",
			},
			["[c"] = {
				function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end,
				"Git: previous hunk",
			},
			["<leader>g"] = {
				h = {
					u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage hunk" },
					p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview hunk" },
				},
				S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage buffer" },
				R = { "<cmd>Gitsigns reset_buffer<cr>", "Reser buffer" },
				B = {
					function()
						gs.blame_line({ full = true })
					end,
					"Blame line",
				},
				t = {
					name = "toggle",
					b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle blame" },
					d = { "<cmd>Gitsigns toggle_deleted<cr>", "Toggle deleted" },
				},
				d = { "<cmd>Gitsigns diffthis<cr>", "diff" },
				D = {
					function()
						gs.diffthis("~")
					end,
					"diff~",
				},
			},
		}, {
			buffer = bufnr,
			mode = { "n", "v" },
			["<leader>gh"] = {
				name = "Hunk",
				s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
				r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
			},
		}, {
			buffer = bufnr,
			mode = { "o", "x" },
			ih = { ":<C-U>Gitsigns select_hunk<cr>", "Select hunk" },
		})
	end,
})
