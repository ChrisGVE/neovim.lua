vim.env.fancy_symbols_enabled = 1

--------------------------------------------------
-- Settings
--------------------------------------------------
vim.opt.exrc = true
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("config") .. "/undodir"
vim.opt.undofile = true
vim.opt.cmdheight = 2
vim.opt.updatetime = 50
vim.opt.isfname = vim.opt.isfname + "@-@"
vim.opt.belloff = "all"
vim.opt.compatible = false
vim.cmd([[ filetype plugin on ]])
vim.cmd([[ filetype indent on ]])
vim.opt.ls = 2
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.syntax = vim.opt.syntax + "on"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.encoding = "utf-8"
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamed"
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.completeopt = vim.opt.completeopt + "menuone" + "longest"
vim.opt.scrolloff = 7
vim.opt.backspace = "indent,eol,start"
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.termguicolors = true
-- vim.opt.mouse = nil
vim.opt.completeopt = "menu,menuone,noselect"
vim.g.timoutlen = 500

-- FixCursorHold set update time
vim.g.curshold_updatime = 1000

-- Fancy Symbols!!
vim.cmd("let g:webdevicons_enable = 0")

----------------------------------------------------
-- System setup
----------------------------------------------------
-- Flagging unncessary whitespace
vim.cmd([[ highlight BadWhitespace ctermbg=red guibg=darkred ]])

-- disable autocomment in newline
-- vim.cmd([[ autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]])

----------------------------------------------------
-- Neovim features
----------------------------------------------------
-- spell checkers
vim.opt.spelllang = "en" -- spell languages
vim.opt.spellsuggest = "best,9" -- Show nine spell checking candidates at most
