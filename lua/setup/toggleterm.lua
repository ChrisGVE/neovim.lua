require'toggleterm'.setup{
    -- size can be a number of function which is passed the current terminal
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = [[<leader>t]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    autochdir = false,
    highlights = {
        Normal = {
            guigb = 'blue',
        },
        NormalFloat = {
            link = 'Normal',
        },
        FloatBorder = {
            guifg = '',
            guigb = 'blue',
        }
    },
    -- shading_factor = '<number>', -- the degree by which to darken to terminal color, default: 1
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = 'horizontal', -- 'vertical', 'horizontal', 'tab', 'float'
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to float
    --[[ float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for detals on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'single', -- 'single', 'double', 'shadow', 'cuvers', other options supported by win open
        width = 60,
        height = 40,
        winblend = 3,
        highlights = {
            border = 'Normal',
            background = 'Normal',
        }
    } ]]
}
