----------------------------------------
-- Telescope setup and configuration
----------------------------------------

local telescope = require('telescope')
local trouble = require('trouble.providers.telescope')

telescope.setup {
    defaults = {
        mappings = {
            i = { ["<C-t>"] = trouble.open_with_trouble },
            n = { ["<C-t>"] = trouble.open_with_trouble },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                       -- false will only do exact matching
            override_generic_sorter = true,     -- override the generic sorter
            override_file_sorter = true,        -- override the file sorter
            ccase_mode = "smart_case",          -- or "ignore_case" or "respect_case"
                                                -- the default case_mode is "smart_case"
        },
        fzf_writer = {
            minimum_grep_characters = 2,
            minimum_files_characters = 2,
            use_highlighter = true,
        },
        frecency = {
            db_root = vim.fn.stdpath('data') .. '/databases/',
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = { '*.git/*', '*/tmp/*' },
            disable_devicons = false,
            workspaces = {
                ['conf'] = '/Users/chris/.config',
                ['keyboards'] = '/Users/chris/dev/Keyboard/qmk_firmware_fork',
                -- .. 
            }
        },
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

-- FIXME check why fzy_native is messing up telescope
-- telescope.load_extension('fzy_native')
telescope.load_extension('gh')
telescope.load_extension('frecency')
-- telescope.load_extension('cheat')
-- telescope.load_extension('neoclip')
telescope.load_extension('harpoon')
