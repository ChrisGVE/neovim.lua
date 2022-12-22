----------------------------------------
-- Treesitter
----------------------------------------

require("nvim-treesitter.configs").setup({
    ensure_installed = { 'help', 'c', 'lua', 'cpp', 'markdown', 'latex', 'sql', 'rust', 'vim' },
    sync_install = false,
    auto_install = true,

	-- ignore_install = { "javascript" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		-- disable = { "c", "rust" },  -- list of language that will be disabled
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	rainbow = {
		enable = true,
		-- disable ={ 'jsx', 'cpp' }, list of language you want o disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang ->  boolean
		max_file_lines = nil, -- Do not nable or files with omre han n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},

	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},

	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},

	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similr to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",

				-- Or your can define your own textobjects like this
				["iF"] = {
					python = "(function_definition) @function",
					cpp = "(function_definition) @function",
					c = "(function_definition) @function",
					java = "(function_definition) @function",
				},
			},
			-- Swap the node under the cursor with the next or previous one
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
			-- Define mapping to jump to the next or previous text objects,
			-- this is similar to ]m, [m, ]M, [M Neovim's mapping to jump to
			-- the next or previous function.
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			-- peek_definition_code: show textobject surrounding definition as
			-- determined using Neovim's LSP in a floating window. Press the
			-- shortcut twice to enter the floating wingdow.
			lsp_interop = {
				enable = true,
				border = "none",
				peek_definition_code = {
					["<leader>df"] = "@function.outer",
					["<leader>dF"] = "@class.outer",
				},
			},
		},
	},

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
