----------------------------------------
-- Telescope setup and configuration
----------------------------------------

local telescope = require('telescope')

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<C-h>'] = R('telescope').extensions.hop.hop, -- hop.hop_toggle_selection
                ['<C-space>'] = function(prompt_bufnr)
                    local opts = {
                        callback = actions.toggle_selection,
                        loop_callback = actions.send_selected_to_qflist,
                    }
                    require('telescope').extensions.hop._hop_loop(prompt_bufnr, opts)
                end,
            },
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
        -- fzf_writer = {
        --     minimum_grep_characters = 2,
        --     minimum_files_characters = 2,
        --     use_highlighter = true,
        -- },
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        hop = {
            keys = {"a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
                    "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
                    "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
                    "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", },
        -- Highlight groups to link to signs and lines; the below configuration refers to demo
            -- sign_hl typically only defines foreground to possibly be combined with line_hl
            sign_hl = { "WarningMsg", "Title" },
            -- optional, typically a table of two highlight groups that are alternated between
            line_hl = { "CursorLine", "Normal" },
        -- options specific to `hop_loop`
            -- true temporarily disables Telescope selection highlighting
            clear_selection_hl = false,
            -- highlight hopped to entry with telescope selection highlight
            -- note: mutually exclusive with `clear_selection_hl`
            trace_entry = true,
            -- jump to entry where hoop loop was started from
            reset_selection = true,
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
telescope.load_extension('fzy_native')
telescope.load_extension('hop')
telescope.load_extension('gh')
telescope.load_extension('frecency')
-- telescope.load_extension('cheat')
-- telescope.load_extension('neoclip')
telescope.load_extension('harpoon')

