----------------------------------------
-- Key mapping
----------------------------------------

-- Leader key
vim.g.mapleader = '\\'

-- Registering to WhichKey
local wk = require("which-key")

local telescope = require('telescope.builtin')
local telescope_ext = require('telescope').extensions
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- Normal mode simple shortcuts
wk.register({
    ['<leader>r'] = { ':set relativenumber!<cr>', 'Relative number toggle' },
    ["<S-cr>"] = { "O<esc>", "Insert blank line above" },
    ["<cr>"] = { "o<esc>", "Insert blank line below" },
    ["//"] = { ":noh<cr>", "Clear search results" },
    ["<leader>1"] = { ":bp<cr>", "Previous buffer" },
    ["<leader>2"] = { ":bn<cr>", "Next buffer" },
    ["<leader>n"] = { vim.cmd.NvimTreeToggle, "Navigation tree toggle" },
    ["<leader>t"] = { vim.cmd.ToggleTerm, "Terminal toggle" },
    ['<C-h>'] = { function() ui.nav_file(1) end, "Navigate to harpoon file 1" },
    ['<C-t>'] = { function() ui.nav_file(2) end, "Navigate to harpoon file 2" },
    ['<C-n>'] = { function() ui.nav_file(3) end, "Navigate to harpoon file 3" },
    ['<C-s>'] = { function() ui.nav_file(4) end, "Navigate to harpoon file 4" },
})

-- Visual mode simple shortcuts
wk.register({
    mode = 'v',
    J = { ":m '>|1<cr>gv=gv", 'Move selected block down' },
    K = { ":m '<-2<cr>gv=gv", 'Move selected block up' }
})

-- Buffer navigation
wk.register({
    ["<leader>b"] = {
        name = "buffer",
        p = { ":bp<cr>", "Previous buffer" },
        n = { ":bn<cr>", "Next buffer" },
        d = { ":bd<cr>", "Delete current buffer" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        a = { function() mark.add_file() end, "Add file to harpoon" },
        h = { function() ui.toggle_quick_menu() end, "Harpoon menu" },
        ['1'] = { function() ui.nav_file(1) end, "Navigate to harpoon file 1" },
        ['2'] = { function() ui.nav_file(2) end, "Navigate to harpoon file 2" },
        ['3'] = { function() ui.nav_file(3) end, "Navigate to harpoon file 3" },
        ['4'] = { function() ui.nav_file(4) end, "Navigate to harpoon file 4" },
    },
})

-- Editor shortcuts
wk.register({
    ['<leader>e'] = {
        name = 'edit',
        s = { function() telescope.symbols({sources = {'emoji', 'kaomoji', 'gitmoji'} }) end , "Insert symbol" },
        u = { vim.cmd.UndotreeToggle, "Undo tree toggle" },
    },
})

-- File
wk.register({
    ['<leader>f'] = {
        name = 'file',
        n = { '<cmd>enew<cr>', 'New file' },
        f = { function()
            telescope.find_files();
        end, 'File file' },
        -- r = { telescope.oldfiles, 'Recent file' },
        r = { function()
            telescope_ext.frecency.frecency()
        end, 'Recent files' },
        c = { function()
            telescope.find_files({cwd='~/.config/'})
        end, "Config files" },
        g = { function()
            telescope.live_grep()
        end, "Live grep" },
        s = { function()
            telescope.grep_string({ search = vim.fn.input("Grep > ") });
        end, "Grep string"},
    },
})

-- Git
wk.register({
    ['<leader>g'] = {
        name = 'git',
        b = { function()
            telescope.git_bcommits()
        end, "Buffer's commits" },
        c = { function()
            telescope.git_commits()
        end, "Project's commits" },
        s = { function()
            telescope.git_status()
        end, "Status" },
        h = { function()
            telescope.git_stash()
        end, "Stash" },
        r = { function()
            telescope.git_branches()
        end, "Projects' branches" },
        f = { function()
            telescope.git_files()
        end, "Projects' files" },
        g = { vim.cmd.Git, "Fugitive" },
    },
})

-- Code
wk.register({
    ['<leader>c'] = {
        name = 'code',
        D = { function()
            telescope.diagnostics()
        end, 'Diagnostics' },
        f = { function()
            telescope.lsp_references()
        end, 'References' },
        i = { function()
            telescope.lsp_implementations()
        end, 'Goto the implementation' },
        d = { function()
            telescope.lsp_definitions()
        end, 'Goto definition' },
        t = { function()
            telescope.lsp_type_definitions()
        end, 'Goto type definition' },
        s = { function()
            telescope.lsp_document_symbols()
        end, 'Document symbols in current buffer' },
--        f = { '<cmd>Format<cr>', 'Code formatter' },
    },
})

-- Language
wk.register({
    ['<leader>l'] = {
        mode = { "n", "i" },
        name = 'language',
        s = { function()
            telescope.spell_suggest()
        end, 'Spell suggestion' },
        z = { '<cmd>set spell!<cr>', "Spellchecker toggle" },
    },
})

-- Help
wk.register({
    ["<leader>h"] = {
        name = "help",
        t = { function()
            telescope.help_tags()
        end, 'Help tags' },
        b = { "<cmd>Telescope builtin<cr>", 'Telescope buildins' },
    },
})
