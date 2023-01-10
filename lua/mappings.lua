----------------------------------------
-- Key mapping
----------------------------------------

-- Leader key
vim.g.mapleader = "\\"

-- tmux remapping
vim.g.tmux_navigator_no_mappings = 1

-- Registering to WhichKey
local wk = require("which-key")

local telescope = require("telescope.builtin")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Normal mode simple shortcuts
wk.register({
	["<leader>r"] = { ":set relativenumber!<cr>", "Relative number toggle" },
	J = { "mzJ`z", "Join line + cursor fixed" },
	["<C-d>"] = { "<C-d>zz", "Half down, line middle" },
	["<C-u>"] = { "<C-u>zz", "Half up, line middle " },
	["<S-cr>"] = { "O<esc>", "Insert blank line above" },
	["<cr>"] = { "o<esc>", "Insert blank line below" },
	["//"] = { ":noh<cr>", "Clear search results" },
	["<leader>1"] = { ":bp<cr>", "Previous buffer" },
	["<leader>2"] = { ":bn<cr>", "Next buffer" },
	["<leader>n"] = { vim.cmd.NvimTreeToggle, "Navigation tree toggle" },
	["<leader>t"] = { vim.cmd.ToggleTerm, "Terminal toggle" },
	["<C-h>"] = {
		function()
			ui.nav_file(1)
		end,
		"Navigate to harpoon file 1",
	},
	["<C-t>"] = {
		function()
			ui.nav_file(2)
		end,
		"Navigate to harpoon file 2",
	},
	["<C-n>"] = {
		function()
			ui.nav_file(3)
		end,
		"Navigate to harpoon file 3",
	},
	--     ['<C-s>'] = { function() ui.nav_file(4) end, "Navigate to harpoon file 4" },
	["zn"] = { "<cmd>ZenMode<cr>", "Toggle Zen mode" },
	["<C-\\>"] = { ":<C-U>TmuxNavigatePrevious<cr>", "Go to the previous pane" },
})

-- Visual mode simple shortcuts
wk.register({
	mode = "v",
	J = { ":m '>+1<cr>gv=gv", "Move selected block down" },
	K = { ":m '<-2<cr>gv=gv", "Move selected block up" },
})

-- Buffer navigation
wk.register({
	["<leader>b"] = {
		name = "buffer",
		p = { ":bp<cr>", "Previous buffer" },
		n = { ":bn<cr>", "Next buffer" },
		d = { ":bd<cr>", "Delete current buffer" },
		f = { "<cmd>Telescope buffers<cr>", "Find" },
		a = {
			function()
				mark.add_file()
			end,
			"Add file to harpoon",
		},
		h = {
			function()
				ui.toggle_quick_menu()
			end,
			"Harpoon menu",
		},
		["1"] = {
			function()
				ui.nav_file(1)
			end,
			"Navigate to harpoon file 1",
		},
		["2"] = {
			function()
				ui.nav_file(2)
			end,
			"Navigate to harpoon file 2",
		},
		["3"] = {
			function()
				ui.nav_file(3)
			end,
			"Navigate to harpoon file 3",
		},
		["4"] = {
			function()
				ui.nav_file(4)
			end,
			"Navigate to harpoon file 4",
		},
	},
})

-- Editor shortcuts
wk.register({
	["<leader>e"] = {
		name = "edit",
		s = {
			function()
				telescope.symbols({ sources = { "emoji", "kaomoji", "gitmoji" } })
			end,
			"Insert symbol",
		},
		u = { vim.cmd.UndotreeToggle, "Undo tree toggle" },
	},
})

-- File
wk.register({
	["<leader>f"] = {
		name = "file",
		n = { "<cmd>enew<cr>", "New file" },
		f = { "<cmd>Telescope find_files<cr>", "File file" },
		r = { "<cmd>Telescope frecency<cr>", "Recent files" },
		c = {
			function()
				telescope.find_files({ cwd = "~/.config/" })
			end,
			"Config files",
		},
		g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
		s = {
			function()
				telescope.grep_string({ search = vim.fn.input("Grep > ") })
			end,
			"Grep string",
		},
	},
})

-- Markdown
wk.register({
	["<leader>m"] = {
		name = "markdown",
		v = { "<cmd>Glow<cr>", "View markdown" },
        t = { "<cmd>TableModeToggle<cr>", "Table mode toggle" },
        T = { "<cmd>Tableize<cr>", "Format a table" },
	},
})
vim.g.simple_todo_map_keys = 0
wk.register({
	mode = { "n", "i", "v" },
	["<leader>m"] = {
		name = "markdown",
		I = { "<Plug>(simple-todo-new-start-of-line)", "New todo (start of line)" },
		i = { "<Plug>(simple-todo-new)", "New todo" },
		o = { "<Plug>(simple-todo-below)", "New todo (below)" },
		O = { "<Plug>(simple-todo-above)", "New todo (above)" },
		s = { "<Plug>(simple-todo-switch)", "Switch todo" },
		x = { "<Plug>(simple-todo-mark-as-done)", "Mark todo as done" },
		X = { "<Plug>(simple-todo-mark-as-undone)", "Mark todo as undone" },
	},
})

-- Obsidian
wk.register({
	["<leader>o"] = {
		name = "obsidian",
		n = { "<cmd>ObsidianNew<cr>", "New obsidian note" },
		f = { "<cmd>ObsidianFollowLink<cr>", "Follow link under the cursor" },
		L = { "<cmd>ObsidianLinkNew<cr>", "Create a new note and link it" },
		l = { "<cmd>ObsidianLink<cr>", "Link" },
		s = { "<cmd>ObsidianSearch<cr>", "Search in vault" },
		o = { "<cmd>ObsidianOpen<cr>", "Open a note in Obsidian app" },
		y = { "<cmd>ObsidianYesterday<cr>", "Open/create daily note for previous day" },
		t = { "<cmd>ObsidianToday<cr>", "Open/create daily note for today" },
		b = { "<cmd>ObsidianBacklinks<cr>", "List of backlinks for current buffer" },
	},
})
-- Mapping ObsidianFollowLink to gf with passtrough
wk.register({
	gf = {
		function()
			if require("obsidian").util.cursor_on_markdown_link() then
				return "<cmd>ObsidianFollowLink<cr>"
			else
				return "gf"
			end
		end,
		"Go to file under cursor or follow Obsidian link",
	},
})

-- Git
wk.register({
	["<leader>g"] = {
		name = "git",
		B = { "<cmd>Telescope git_bcommits<cr>", "Buffer's commits" },
		C = { "<cmd>Telescope git_commits<cr>", "Project's commits" },
		S = { "<cmd>Telescope git_status<cr>", "Status" },
		h = { "<cmd>Telescope git_stash<cr>", "Stash" },
		P = { "<cmd>Telescope git_branches<cr>", "Projects' branches" },
		f = { "<cmd>Telescope git_files<cr>", "Projects' files" },
		g = { vim.cmd.Git, "Fugitive" },
		p = { "<cmd>Git push<cr>", "Git push" },
		c = { "<cmd>Git commit -a -v<cr>", "Git commit" },
		l = { "<cmd>Git pull<cr>", "Git pull" },
		r = { "<cmd>Git rebase -i<cr>", "Git rebase" },
		d = { "<cmd>Git diff<cr>", "Git diff" },
		L = { "<cmd>Git log<cr>", "Git log" },
		m = { "<cmd>Git merge<cr>", "Git merge" },
		b = { "<cmd>Git blame<cr>", "Git blame" },
		s = { "<cmd>Gvdiffsplit<cr>", "Git diff split" },
	},
})

-- Code
wk.register({
	["<leader>c"] = {
		name = "code",
		C = { "<cmd>Mason<cr>", "Open mason" },
	},
})

-- Language
wk.register({
	["<leader>l"] = {
		mode = { "n", "i" },
		name = "language",
		s = { "<cmd>Telescope spell_suggest<cr>", "Spell suggestion" },
		z = { "<cmd>set spell!<cr>", "Spellchecker toggle" },
	},
})

-- Help
wk.register({
	["<leader>h"] = {
		name = "help",
		t = { "<cmd>Telescope help_tags<cr>", "Help tags" },
		b = { "<cmd>Telescope builtin<cr>", "Telescope buildins" },
		w = { "<cmd>WhichKey<cr>", "Show all keybindings with Which-key" },
	},
})

-- Window
wk.register({
	["<C-w>"] = {
		name = "window",
		h = { ":<C-U>TmuxNavigateLeft<cr>", "Go to the left window" },
		j = { ":<C-U>TmuxNavigateDown<cr>", "Go to the down window" },
		k = { ":<C-U>TmuxNavigateUp<cr>", "Go to the up window" },
		l = { ":<C-U>TmuxNavigateRight<>", "Go to the right window" },
	},
})
-- The primeagen mappings

-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<leader>vwm", function()
-- require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
-- require("vim-with-me").StopVimWithMe()
-- end)

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
