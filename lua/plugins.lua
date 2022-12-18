----------------------------------------
-- Plugin support
----------------------------------------
-- load a configuration file
local function get_setup(name)
    return string.format('require("setup/%s")', name)
end

-- check if Packer is installed, if not installs.
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- automatically run :PackerCompile when plugins.lua is changed
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]]

require('packer').startup({function(use)
    ----------------------------------------
    -- SYSTEM
    ----------------------------------------
    --
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    --
    -- TMUX Integration
    -- use('christoomey/vim-tmux-navigator')
    --
    -- Remember: open at the last position
    use({
        'vladdoster/remember.nvim',
        config = get_setup("remember")
    })
    --
    -- Devicons
    use({
        'kyazdani42/nvim-web-devicons',
        config = get_setup('nvim-web-devicons')
    })
    --
    -- Notifications
    use({
        'rcarriga/nvim-notify',
        config = get_setup('nvim-notify'),
    })

    ----------------------------------------
    -- INTERFACE
    ----------------------------------------
    --
    -- Dracula
    use({
        'Mofiqul/dracula.nvim',
        config = function()
            vim.cmd [[ colorscheme dracula ]]
        end
    })
    --
    -- Bufferline
    use({
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = get_setup('bufferline'),
    })
    --
    -- LuaLine
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = get_setup('lualine'),
    })
    --
    -- Which key
    use({
        'folke/which-key.nvim',
        config = get_setup('which-key'),
    })
    --
    -- Colorizer
    use({
        'norcalli/nvim-colorizer.lua',
        config = get_setup('nvim-colorizer')
    })
    --
    -- File browser
    use({
        'kyazdani42/nvim-tree.lua',
        require = {
            'kyazdani42/nvim-web-devicons',
        },
        config = get_setup('nvim-tree'),
    })
    --
    -- Terminal
    use({
        'akinsho/toggleterm.nvim',
        config = get_setup('toggleterm')
    })
    --
    -- Vim-Fugitive
    use({
        'tpope/vim-fugitive'
    })


    ----------------------------------------
    -- TELESCOPE
    ----------------------------------------
    --
    -- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-hop.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'nvim-telescope/telescope-github.nvim',
            'nvim-telescope/telescope-symbols.nvim',
        },
        config = get_setup('telescope')
    })
    --
    -- FZF native
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    })
    --
    -- Frecency
    use({
        'nvim-telescope/telescope-frecency.nvim',
        requires = {
            'kkharji/sqlite.lua',
        }
    })
    --
    -- Harpoon
    use({
        'theprimeagen/harpoon',
    })

    ----------------------------------------
    -- EDITING TOOLS
    ----------------------------------------
    --
    -- LuaSnip
    use('L3MON4D3/LuaSnip')
    --
    -- Parenthese management
    use('tpope/vim-surround')
    --
    -- Repeat plugin actions
    use('tpope/vim-repeat')
    --
    -- UndoTree
    use('mbbill/undotree')


    ----------------------------------------
    -- TREESITTER
    ----------------------------------------
    --
    -- Treesitter
    use({
        'nvim-treesitter/nvim-treesitter',
        -- requires = {
            -- 'nvim-treesitter/playground',
            -- 'p00f/nvim-ts-rainbow',
            -- 'nvim-treesitter/nvim-treesitter-textobjects',
            -- 'mfussenegger/nvim-ts-hint-textobject',
        -- },
        run = ":TSUpdate",
        config = get_setup('treesitter'),
    })
    --
    -- Autopairs
    use({
        "windwp/nvim-autopairs",
        config = get_setup("npairs"),
    })


    ----------------------------------------
    -- LANGUAGE SUPPORT
    ----------------------------------------
    --
    -- LSP-Zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'hrsh7th/cmp-nvim-lsp-document-symbol'},
            {'hrsh7th/cmp-nvim-lsp-signature-help'},
            {'tamago324/cmp-zsh'},
            {'lukas-reineke/cmp-under-comparator'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
        config = get_setup('lsp-zero'),
    }

    --[[
    --
    -- LSP-config
    use({
        'neovim/nvim-lspconfig',
        config = get_setup('lspconfig')
    })
    --
    -- LSP-status
    use({
        'nvim-lua/lsp-status.nvim',
        config = get_setup('lspstatus')
    })
    --
    -- Autocomplete
    use({
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'saadparwaiz1/cmp_luasnip',
            'tamago324/cmp-zsh',
            'lukas-reineke/cmp-under-comparator',
        },
        config = get_setup('cmp')
    })
    --]]
    --
    --
    ----------------------------------------
    -- AUTOMATICALLY INSTALL PACKER
    ----------------------------------------
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end,
config = {
    display = {
        open_fn = require('packer.util').float,
    }
}
})

