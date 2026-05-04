local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path
	})
	vim.api.nvim_command 'packadd packer.nvim'
end

-- don't throw any error on first use by packer
local ok, packer = pcall(require, "packer")
if not ok then return end

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup({
    function(use)
        -- Package Manager --
        use('wbthomason/packer.nvim')

        -- Required plugins --
        use('nvim-lua/plenary.nvim')

        --------------------------------------------------------
        -- Theme, Icons, Statusbar, Bufferbar, Welcome screen --
        --------------------------------------------------------

        use({ -- icons
            'kyazdani42/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup()
            end,
        })

        use({ -- themes
            "catppuccin/nvim",
            as = "catppuccin",
            config = function()
                require('crawraps.plugins.catppuccin')
            end,
        })
        use({
          "ellisonleao/gruvbox.nvim",
          as = "gruvbox",
        })
        use({
          "savq/melange-nvim",
          as = "gruvbox",
          config = function()
              require('crawraps.plugins.gruvbox')
          end,
        })
        use "sainnhe/everforest"

        use({'stevearc/dressing.nvim'}) -- popups

        use({ -- bottom info line
            'nvim-lualine/lualine.nvim',
            after = 'catppuccin',
            event = 'BufEnter',
            config = function()
                require('crawraps.plugins.lualine')
            end,
        })

        use({ -- top buffer line
            'akinsho/bufferline.nvim',
            tag = "v3.*",
            requires = 'nvim-tree/nvim-web-devicons',
            config = function()
                require('crawraps.plugins.bufferline')
            end,
        })

        use({ -- welcome screen
            'goolord/alpha-nvim',
            after = 'nvim-web-devicons',
            config = function ()
                require('crawraps.plugins.alpha')
            end
        })
        
        use('MunifTanjim/nui.nvim')

        -----------------------------------
        -- Treesitter: Better Highlights --
        -----------------------------------

        use({
            {
                'nvim-treesitter/nvim-treesitter',
                event = 'CursorHold',
                run = ':TSUpdate',
                config = function()
                    require('crawraps.plugins.treesitter')
                end,
            },
            { 'nvim-treesitter/playground', after = 'nvim-treesitter' },
            { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
            { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter' },
            { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' },
            { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' },
        })

        --------------------------
        -- Editor UI Niceties --
        --------------------------

        use({
            'lukas-reineke/indent-blankline.nvim',
            event = 'BufRead',
            config = function()
                require('crawraps.plugins.indentline')
            end,
        })

        use({
            'norcalli/nvim-colorizer.lua',
            event = 'CursorHold',
            config = function()
                require('crawraps.plugins.colorizer')
            end,
        })

        ---------------
        -- Git Stuff --
        ---------------

        use({
            'lewis6991/gitsigns.nvim',
            event = 'BufRead',
            config = function()
                require('crawraps.plugins.gitsigns')
            end,
        })

        use({
            'rhysd/git-messenger.vim',
            event = 'BufRead',
            config = function()
                require('crawraps.plugins.git-messenger')
            end,
        })

        use({
            'sindrets/diffview.nvim',
            event = 'BufRead',
            config = function()
                require('crawraps.plugins.diffview')
            end,
        })

        ---------------------------------
        -- Navigation and Fuzzy Search --
        ---------------------------------

        use({
            'nvim-tree/nvim-tree.lua',
            event = 'CursorHold',
            config = function()
                require('crawraps.plugins.nvim-tree')
            end,
        })

        use({
            'shatur/neovim-session-manager',
            config = function()
              require('crawraps.plugins.session-manager')
            end,
        })

        use({
            {
                'nvim-telescope/telescope.nvim',
                tag = '0.1.5',
                event = 'CursorHold',
                config = function()
                    require('crawraps.plugins.telescope')
                end,
                after = 'plenary.nvim'
            },
--            {
--                'nvim-telescope/telescope-fzf-native.nvim',
--                after = 'telescope.nvim',
--                run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
--                config = function()
--                    require('telescope').load_extension('fzf')
--                end,
--            },
            {
                'nvim-telescope/telescope-symbols.nvim',
                after = 'telescope.nvim',
            },
        })

        use({
            'numToStr/Navigator.nvim',
            event = 'CursorHold',
            config = function()
                require('crawraps.plugins.navigator')
            end,
        })

        use({
            'phaazon/hop.nvim',
            event = 'BufRead',
            config = function()
                require('crawraps.plugins.hop')
            end,
        })

        use({
            'karb94/neoscroll.nvim',
            event = 'WinScrolled',
            config = function()
                require('neoscroll').setup({ hide_cursor = false })
            end,
        })

        use({
          "SmiteshP/nvim-navbuddy",
          requires = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim"
          }
        })

        -------------------------
        -- Editing to the MOON --
        -------------------------

        use({
            'numToStr/Comment.nvim',
            event = 'BufRead',
            config = function()
                require('crawraps.plugins.comment')
            end,
        })

        use('numToStr/prettierrc.nvim')

        use({
            'tpope/vim-surround',
            event = 'BufRead',
            requires = {
                {
                    'tpope/vim-repeat',
                    event = 'BufRead',
                },
            },
        })

        use({
            'wellle/targets.vim',
            event = 'BufRead',
        })

        use({
            'AndrewRadev/splitjoin.vim',
            -- NOTE: splitjoin won't work with `BufRead` event
            event = 'CursorHold',
        })

        --------------
        -- Terminal --
        --------------

        use({
            'numToStr/FTerm.nvim',
            event = 'CursorHold',
            config = function()
                require('crawraps.plugins.fterm')
            end,
        })

        -----------------------------------
        -- LSP, Completions and Snippets --
        -----------------------------------

        -- use {
        --   'Exafunction/codeium.vim',
        --   config = function ()
        --     vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
        --     vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
        --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
        --   end
        -- }

        use({'github/copilot.vim'})

        use({
            'neovim/nvim-lspconfig',
            event = 'BufRead',
            config = function()
                require('crawraps.plugins.lsp.servers')
            end,
            requires = {
                {
                    -- WARN: Unfortunately we won't be able to lazy load this
                    'hrsh7th/cmp-nvim-lsp',
                },
            },
        })

        use({
            'jose-elias-alvarez/null-ls.nvim',
            event = 'BufRead',
            config = function()
                require('crawraps.plugins.lsp.null-ls')
            end,
        })

        use({
            "williamboman/mason.nvim",
            as = 'mason',
            config = function()
                require('crawraps.plugins.lsp.mason')
            end,
        })

        use ({
          "SmiteshP/nvim-navic",
          requires = "neovim/nvim-lspconfig",
        })

        use({
            {
                'hrsh7th/nvim-cmp',
                event = 'InsertEnter',
                config = function()
                    require('crawraps.plugins.lsp.nvim-cmp')
                end,
                requires = {
                    {
                        'L3MON4D3/LuaSnip',
                        event = 'InsertEnter',
                        config = function()
                            require('crawraps.plugins.lsp.luasnip')
                        end,
                        requires = {
                            {
                                'rafamadriz/friendly-snippets',
                                event = 'CursorHold',
                            },
                        },
                    },
                },
            },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
        })

        -- NOTE: nvim-autopairs needs to be loaded after nvim-cmp, so that <CR> would work properly
        use({
            'windwp/nvim-autopairs',
            event = 'InsertCharPre',
            after = 'nvim-cmp',
            config = function()
                require('crawraps.plugins.pairs')
            end,
        })

        use({
            'j-hui/fidget.nvim',
            tag = 'legacy',
            config = function()
                require('fidget').setup()
            end,
        })
        
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
    },
})
