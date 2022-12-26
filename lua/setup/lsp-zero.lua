local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"sumneko_lua",
	"clangd",
	"cmake",
	"diagnosticls",
	"dockerls",
	"dotls",
	"bashls",
	"yamlls",
	"lemminx",
	"sqlls", -- alternative: sqls
	"rust_analyzer",
	"pyright", -- alternative: jedi_language_server, sourcery
	"texlab", -- alternative: ltex
	"marksman", -- alternative: prosemd_lsp, remark_ls, zk
})

lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item(cmp_select)
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif has_words_before() then
			cmp.complete()
		else
			fallback()
		end
	end, { "i", "s" }),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item(cmp_select)
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "s" }),
})

local cmp_snippet = {
	expand = function(args)
		require("luasnip").lsp_expand(args.body)
	end,
}

-- formatting with lspkind
local cmp_formatting = {
	format = lspkind.cmp_format({
		with_text = false, -- do not show text alongside icons
		maxwidth = 50,
	}),
}

local cmp_sources = {
	{ name = "nvim_lsp", keyword_length = 3 },
	{ name = "luasnip", keyword_length = 3 },
	{ name = "nvim_lsp_signature_help", keyword_length = 3 },
	{ name = "zsh", keyword_length = 3 },
	{ name = "buffer", keyword_length = 3, option = {
		keyword_pattern = [[\k\+]],
	} },
}

-- Set configuration for specific filetype
local cmp_filetype = {
	"gitcommit",
	{
		sources = cmp.config.sources({
			{ name = "cmp_git" }, -- You can specify the cmp_git source if were installed it
		}, {
			{ name = "buffer" },
		}),
	},
}

local cmp_cmdline = {
	-- Use buffer source for `/` and `?` (if you enabled `native_menu, this won't work anymore).
	{ { "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	} },
	-- Use cmdline & path source for `:` (if you enabled `native_menu`, this won't work anymore).
	{
		":",
		{
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		},
	},
}

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	snippet = cmp_snippet,
	completeopt = "menu, menuone, noinsert",
	formatting = cmp_formatting,
	sources = cmp_sources,
	filetype = cmp_filetype,
	cmdline = cmp_cmdline,
})

local wk = require("which-key")

lsp.on_attach(function(client, bufnr)
	wk.register({
		buffer = bufnr,
		["<leader>c"] = {
			name = "code",
			l = { "<cmd>Telescope diagnostics<cr>", "List of diagnostics" },
			r = { "<cmd>Telescope lsp_references<cr>", "References" },
			i = { "<cmd>Telescope lsp_implementations<cr>", "Goto the implementation" },
			d = { "<cmd>Telescope lsp_definitions<cr>", "Goto definition" },
			t = {
				"<cmd>Telescope lsp_type_definitions<cr>",
				"Goto type definition",
			},
			S = {
				"<cmd>Telescope lsp_document_symbols<cr>",
				"Document symbols in current buffer",
			},
			f = { "<cmd>Format<cr>", "Code formatter" },
			K = {
				function()
					vim.lsp.buf.hover()
				end,
				"Hover",
			},
			s = {
				function()
					vim.lsp.buf.workspace_symbol()
				end,
				"Workspace symbols",
			},
			a = {
				function()
					vim.lsp.buf.code_action()
				end,
				"Code action",
			},
			["vd"] = {
				function()
					vim.diagnostic.open_float()
				end,
				"View diagnostics",
			},
			["rr"] = {
				function()
					vim.lsp.buf.references()
				end,
				"References",
			},
			["rn"] = {
				function()
					vim.lsp.buf.rename()
				end,
				"Rename",
			},
		},
		gd = {
			function()
				vim.lsp.buf.definition()
			end,
			"Goto definition",
		},
		["[d"] = {
			function()
				vim.diagnostic.goto_prev()
			end,
			"Goto prev diagnostics",
		},
		["]d"] = {
			function()
				vim.diagnostic.goto_next()
			end,
			"Goto next diagnostics",
		},
	})
	wk.register({
		mode = "i",
		buffer = bufnr,
		["<C-h>"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"Signature help",
		},
	})
end)

lsp.setup()
