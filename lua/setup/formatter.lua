----------------------------------------
-- Formatter setup
----------------------------------------

local formatter = require("formatter")

formatter.setup({
	filetype = {
		sh = {
			-- Shell Script Formatter
			function()
				return {
					exe = "shfmt",
					args = { "-i", 2 },
					stdin = true,
				}
			end,
		},
		lua = {
			-- Stylua
			function()
				return {
					exe = "stylua",
					args = {
						-- '--config-path '
						--     .. os.getenv('XDG_CONFIG_HOME')
						--     .. '/stylua/stylua.toml',
						"-",
					},
					stdin = true,
				}
			end,
		},
		c = {
			-- clang-format
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
				}
			end,
		},
		h = { -- This is the same as c above
			-- clang-format
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
				}
			end,
		},
		cpp = { -- This is the same as c above
			-- clang-format
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
				}
			end,
		},
		terraform = {
			function()
				return {
					exe = "terraform",
					args = { "fmt", "-" },
					stdin = true,
				}
			end,
		},
		python = {
			function()
				return {
					exe = "python3 -m autopep8",
					args = {
						"--in-place --aggressive --aggressive",
						vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = false,
				}
			end,
		},
	},
})

-- Autoformat
-- autocmd BufWritePost *.lua,*.c,*.h,*.sh,*.py,*.cpp FormatWrite
vim.api.nvim_exec(
	[[
    augroup FormatAutogroup
        " autocmd!
        " autocmd BufWritePost *.lua FormatWrite
    augroup END
    ]],
	true
)
