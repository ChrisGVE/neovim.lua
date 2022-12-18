-- Set keys to navigate whilst being in terminal mode
function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'ij', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<cr>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<cr>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<cr>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<cr>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- This comes from tjdevries config manager and is used for telescope-hopAq
P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
