local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'sumneko_lua',
    'clangd',
    'cmake',
    'diagnosticls',
    'dockerls',
    'dotls',
    'bashls',
    'yamlls',
    'lemminx',
    'sqlls', -- alternative: sqls
    'rust_analyzer',
    'pyright', -- alternative: jedi_language_server, sourcery
    'texlab', -- alternative: ltex
    'marksman', -- alternative: prosemd_lsp, remark_ls, zk
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 3 },
        { name = 'nvim_lsp_signature_help', keyword_length = 3 },
        { name = 'zsh', keyword_length = 3 },
    }, {
        { name = 'buffer', keyword_length = 3,
        option = {
            keyword_pattern = [[\k\+]], }},
        })
    })

    -- Set configuration for specific filetype
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the cmp_git source if were installed it
        }, {
            { name = 'buffer' }
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for `:` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

local wk = require("which-key")

lsp.on_attach(function(client, bufnr)
    wk.register({
        buffer = bufnr,
        gd = { function() vim.lsp.buf.definition() end, "Goto definition" },
        K = { function() vim.lsp.buf.hover() end, "Hover" },
        ["[d"] = { function() vim.diagnostic.goto_prev() end, "Goto prev diagnostics" },
        ["]d"] = { function() vim.diagnostic.goto_next() end, "Goto next diagnostics" },
        ["<leader>cs"] = { function() vim.lsp.buf.workspace_symbol() end, "Workspace symbols" },
        ["<leader>cvd"] = { function() vim.diagnostic.open_float() end, "View diagnostics" },
        ["<leader>ca"] = { function() vim.lsp.buf.code_action() end, "Code action" },
        ["<leader>crr"] = { function() vim.lsp.buf.references() end, "References" },
        ["<leader>crn"] = { function() vim.lsp.buf.rename() end, "Rename" },
    })
    wk.register({
        mode = 'i',
        buffer = bufnr,
        ["<C-h>"] = { function() vim.lsp.buf.signature_help() end, "Signature help" },
    })
end)

lsp.setup()
