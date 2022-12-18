-- autopairs
local npairs = require('nvim-autopairs')
local ts_conds = require('nvim-autopairs.ts-conds')
local conds = require('nvim-autopairs.conds')
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    enable_check_bracket_line = false, -- don't add pairs if already ahs a close pair in the same line
    ignored_next_char = '[%w%,]', -- don't add pairs if the next char is alphanumeric
    -- FastWrap 
    fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        offset = 0, -- Offset from pattern match
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
    },
    check_ts = true,
    ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
        javascript = { 'template_string' },
        java = false, -- don't check treesitter on java
    }
})

-- press % => %% only while inside a comment or string
npairs.add_rules({
    Rule('%', '%', 'lua')
        :with_pair(ts_conds.is_ts_node({'string', 'comment'})),
    Rule('$', '$', 'lua')
        :with_pair(ts_conds.is_not_ts_node({'function'})),
    Rule('$$', '$$', 'tex'),
    Rule("$", "$",{"tex", "latex"})
        -- don't add a pair if the next character is %
        :with_pair(conds.not_after_regex("%%"))
        -- don't add a pair if  the previous character is xxx
        :with_pair(conds.not_before_regex("xxx", 3))
        -- don't move right when repeat character
        :with_move(conds.none())
        -- don't delete if the next character is xx
        :with_del(conds.not_after_regex("xx"))
        -- disable adding a newline when you press <cr>
        :with_cr(conds.none()),
    },
    -- disable for .vim files, but it work for another filetypes
    Rule("a", "a", "-vim")
)
