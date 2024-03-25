
-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync 
  augroup end
]])

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires =  {
            'nvim-lua/plenary.nvim',
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    -- Default configuration for telescope goes here:
                    -- config_key = value,
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["J"] = "move_selection_next",
                            ["K"] = "move_selection_previous",
                        }
                    }
                },
            })

            require('telescope').load_extension('fzf')
            require('telescope').load_extension('undo')
            require('telescope').load_extension('luasnip')
        end
    }

    use { 
        'echasnovski/mini.nvim', branch = 'stable',
        config = function ()
            require('mini.ai').setup()
            require('mini.pairs').setup()
        end
    }

    -- use {
    --     "bluz71/vim-nightfly-colors", as = "nightfly",
    --     config = function() vim.cmd('colorscheme nightfly') end
    -- }

    use {
        "catppuccin/nvim", as = "catppuccin",
        config = function() vim.cmd('colorscheme catppuccin') end

    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() 
            require('lualine').setup {
                options = { theme = 'nightfly' },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        {
                            'buffers',
                            mode = 2, -- 0: Shows buffer name
                            -- 1: Shows buffer index
                            -- 2: Shows buffer name + buffer index
                            -- 3: Shows buffer number
                            -- 4: Shows buffer name + buffer number
                            buffers_color = {
                                active = 'StatusLine',   -- color for active buffer
                                inactive = 'StatusLineNC', -- color for inactive buffer
                            },

                        }
                    },
                    lualine_c = {},
                }
            }
        end
    }

    use {
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
                keymaps = {
                    normal = "<leader>ys",
                    delete = "<leader>ds",
                    change = "<leader>cs",
                    visual = "<leader>ys",
                    normal_cur = "<leader>yss",
                    normal_line = "<leader>yS",
                    normal_cur_line = "<leader>ySS",
                    visual_line = "<leader>yS",
                },
            })
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- file explorer
    use { 
        "nvim-tree/nvim-tree.lua",
        config = function() require("nvim-tree").setup({
            disable_netrw       = true,
            hijack_netrw        = true,
            open_on_tab         = false,
        }) end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            -- [[ Configure Treesitter ]]
            -- See `:help nvim-treesitter`
            require('nvim-treesitter.configs').setup {
                -- Add languages to be installed here that you want installed for treesitter
                ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'html', 'css', 'help', 'vim' },

                -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
                auto_install = true,

                highlight = { enable = true },
                indent = { enable = true, disable = { 'python' } },
            }
        end,

        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }

    -- use {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    --     after = "nvim-treesitter",
    --     requires = "nvim-treesitter/nvim-treesitter",
    --     config = function ()
    --         require'nvim-treesitter.configs'.setup {
    --             textobjects = {
    --                 select = {
    --                     enable = true,
    --
    --                     -- Automatically jump forward to textobj, similar to targets.vim
    --                     lookahead = true,
    --
    --                     keymaps = {
    --                         -- You can use the capture groups defined in textobjects.scm
    --                         ["af"] = "@function.outer",
    --                         ["if"] = "@function.inner",
    --                         ["ac"] = "@class.outer",
    --                         -- You can optionally set descriptions to the mappings (used in the desc parameter of
    --                         -- nvim_buf_set_keymap) which plugins like which-key display
    --                         ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
    --                         -- You can also use captures from other query groups like `locals.scm`
    --                         ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
    --                     },
    --                 }
    --             }
    --         }
    --     end
    -- }

    use 'nvim-treesitter/nvim-treesitter-context'

    use {
        "williamboman/mason.nvim",
        config = function ()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    }

    use "neovim/nvim-lspconfig"

    use {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { 'rust_analyzer', "pyright", "lua_ls", "clangd", "gopls", "emmet_ls", "tsserver", "html" },
                automatic_installation = true,
            }

            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,

                ["rust_analyzer"] = function ()
                    require("lspconfig").rust_analyzer.setup {
                        settings = {
                            ['rust-analyzer'] = {
                                check = {
                                    command = "clippy"
                                }
                            }
                        }
                    }
                end,
            }

        end,
        after = "mason.nvim",
    }

    use({
        "L3MON4D3/LuaSnip",
        requires = {
            { 'honza/vim-snippets' },
        },
        config = function ()
            require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/.config/nvim/vim-snippets/snippets"})
        end,
        -- follow latest release.
        tag = "v1.*",
        -- install jsregexp (optional!:).
        run = "make install_jsregexp",
    })

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'saadparwaiz1/cmp_luasnip' },
        },

        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },

                mapping = cmp.mapping.preset.insert({
                    ['J'] = cmp.mapping.select_next_item({}),
                    ['K'] = cmp.mapping.select_prev_item({}),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm {
                        select = true,
                    },
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            if luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            else
                                fallback()
                            end
                        end, {'i', 's'}
                    ),

                    ["<S-Tab>"] = cmp.mapping(
                        function(fallback)
                            if luasnip.jumpable(-1) then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end, {'i', 's'}
                    ),
                }),

                sources = cmp.config.sources(
                    {
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                        { name = "nvim_lua" },

                    },
                    {
                        { name = "path" },
                        { name = "buffer", keyword_length = 3 },
                    }
                ),
            }
        end
    }

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end
    }

    -- use {
    --     "ggandor/leap.nvim",
    --     requires = {{"tpope/vim-repeat"}},
    --     config = function()
    --         require('leap').add_default_mappings()
    --         require('leap').opts.safe_labels = {}
    --     end
    -- }
    --
    -- use {
    --     "ggandor/flit.nvim",
    --     requires = {{"ggandor/leap.nvim"}},
    --     config = function ()
    --         require('flit').setup()
    --     end
    -- }
    --

    use {
        "tpope/vim-repeat",
    }

    use {
        'smoka7/hop.nvim',
        tag = '*',
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require('hop').setup {
                keys = 'etovxqpdygfblzhckisuran'
            }
        end
    }


    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }

    use {
        'mhartington/formatter.nvim', 
        config = function ()
            require("formatter").setup {
                -- Enable or disable logging
                logging = true,
                -- Set the log level
                log_level = vim.log.levels.WARN,
                -- All formatter configurations are opt-in
                filetype = {
                    python = {
                        require("formatter.filetypes.python").black
                    },

                    typescript = {
                        require("formatter.filetypes.typescript").prettier
                    },

                    typescriptreact = {
                        require("formatter.filetypes.typescriptreact").prettier
                    },

                    javascript = {
                        require("formatter.filetypes.javascript").prettier
                    },

                    javascriptreact = {
                        require("formatter.filetypes.javascriptreact").prettier
                    },

                    css = {
                        require("formatter.filetypes.css").prettier
                    },

                    rust = {
                        require("formatter.filetypes.rust").rustfmt
                    }
                }
            }
        end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use {
        'rmagatti/auto-session',
        config = function()
            require("auto-session").setup {
                log_level = "error",
                auto_session_enabled = true,
                auto_session_create_enabled = true,
                auto_save_enabled = true,
                auto_restore_enabled = true,
                -- auto_session_suppress_dirs = { "~/", "~/Downloads", "/"},
            }
        end
    }

    use {
        "benfowler/telescope-luasnip.nvim",
        module = "telescope._extensions.luasnip",  -- if you wish to lazy-load
    }

end)
