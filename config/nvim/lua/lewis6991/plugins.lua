local packer = require('lewis6991.packer')

packer.setup {
  'wbthomason/packer.nvim',

  -- 'lewis6991/moonlight.vim',
  {'lewis6991/github_dark.nvim', config = function()
    vim.cmd.color'github_dark'
  end},

  'lewis6991/tcl.vim',
  -- 'lewis6991/systemverilog.vim',
  'lewis6991/impatient.nvim',
  {'lewis6991/spaceless.nvim', config = [[require('spaceless').setup()]]},
  {'lewis6991/cleanfold.nvim', config = [[require('cleanfold').setup()]]},
  'lewis6991/brodir.nvim',
  'lewis6991/vc.nvim',

  {'lewis6991/foldsigns.nvim',
    config = function()
      require'foldsigns'.setup{
        exclude = {'GitSigns.*'}
      }
    end
  },

  {'lewis6991/hover.nvim', config  = function()
    require('hover').setup{
      init = function()
        require('hover.providers.lsp')
        require('hover.providers.gh')
        require('hover.providers.dictionary')
        require('hover.providers.man')
      end
    }
    vim.keymap.set('n', 'K', require('hover').hover, {desc='hover.nvim'})
    vim.keymap.set('n', 'gK', require('hover').hover_select, {desc='hover.nvim (select)'})
  end},

  {'lewis6991/satellite.nvim', config = function()
    require('satellite').setup()
  end},

  {'lewis6991/gitsigns.nvim', config = "require'lewis6991.gitsigns'" },
  {'lewis6991/spellsitter.nvim', config = [[require('spellsitter').setup()]] },

  'tpope/vim-commentary',
  'tpope/vim-unimpaired',
  'tpope/vim-repeat',
  'tpope/vim-eunuch',
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',

  'kyazdani42/nvim-web-devicons',

  'wellle/targets.vim',
  'michaeljsmith/vim-indent-object',
  'dietsche/vim-lastplace',
  'sindrets/diffview.nvim',
  'folke/trouble.nvim',
  'bogado/file-line', -- Open file:line

  {'AndrewRadev/bufferize.vim',
    cmd = 'Bufferize',
    config = function()
      vim.g.bufferize_command = 'enew'
      -- vim.cmd('autocmd vimrc FileType bufferize setlocal wrap')
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'bufferize',
        group = 'vimrc',
        callback = function()
          vim.opt_local.wrap = true
        end
      })
    end
  },

  --- Filetype plugins ---
  {'tmux-plugins/vim-tmux', ft = 'tmux'  },
  {'derekwyatt/vim-scala' , ft = 'scala' },
  'cespare/vim-toml',
  'martinda/Jenkinsfile-vim-syntax',
  'teal-language/vim-teal',
  'fladson/vim-kitty',
  'raimon49/requirements.txt.vim',
  'euclidianAce/BetterLua.vim',

  {'rcarriga/nvim-notify',
    -- config = function()
    --   require('lewis6991.notify')
    -- end
  },

  {'j-hui/fidget.nvim', config = function()
    require'fidget'.setup()
  end},

  {'mhinz/vim-grepper', config = function()
    vim.g.grepper = {
      dir = 'repo',
    }
    vim.keymap.set({'n', 'x'}, 'gs', '<plug>(GrepperOperator)')
  end},

  {'lewis6991/tmux.nvim', config = function()
    require("tmux").setup{
      navigation = { enable_default_keybindings = true }
    }
  end},

  'ryanoasis/vim-devicons',

  {'neapel/vim-bnfc-syntax',
    config = function()
      -- Argh, why don't syntax plugins ever set commentstring!
      vim.cmd[[autocmd vimrc FileType bnfc setlocal commentstring=--%s]]
      -- This syntax works pretty well for regular BNF too
      vim.cmd[[autocmd vimrc BufNewFile,BufRead *.bnf setlocal filetype=bnfc]]
    end
  },

  {'whatyouhide/vim-lengthmatters', config = function()
    vim.g.lengthmatters_highlight_one_column = 1
    vim.g.lengthmatters_excluded = {'packer'}
  end},

  {'junegunn/vim-easy-align',
    keys = 'ga',
    config = function()
      vim.keymap.set({'x', 'n'}, 'ga', '<Plug>(EasyAlign)')
      vim.g.easy_align_delimiters = {
        [';']  = { pattern = ';'        , left_margin = 0 },
        ['[']  = { pattern = '['        , left_margin = 1, right_margin = 0 },
        [']']  = { pattern = ']'        , left_margin = 0, right_margin = 1 },
        [',']  = { pattern = ','        , left_margin = 0, right_margin = 1 },
        [')']  = { pattern = ')'        , left_margin = 0, right_margin = 0 },
        ['(']  = { pattern = '('        , left_margin = 0, right_margin = 0 },
        ['=']  = { pattern = [[<\?=>\?]], left_margin = 1, right_margin = 1 },
        ['|']  = { pattern = [[|\?|]]   , left_margin = 1, right_margin = 1 },
        ['&']  = { pattern = [[&\?&]]   , left_margin = 1, right_margin = 1 },
        [':']  = { pattern = ':'        , left_margin = 1, right_margin = 1 },
        ['?']  = { pattern = '?'        , left_margin = 1, right_margin = 1 },
        ['<']  = { pattern = '<'        , left_margin = 1, right_margin = 0 },
        ['>']  = { pattern = '>'        , left_margin = 1, right_margin = 0 },
        ['\\'] = { pattern = '\\'       , left_margin = 1, right_margin = 0 },
        ['+']  = { pattern = '+'        , left_margin = 1, right_margin = 1 }
      }
    end
  },

  {'neovim/nvim-lspconfig',
    requires = {
      'stevearc/aerial.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'scalameta/nvim-metals',
      'folke/lua-dev.nvim',
      'ray-x/lsp_signature.nvim',
      'theHamsta/nvim-semantic-tokens',
    },
    config = "require'lewis6991.lsp'"
  },

  {'jose-elias-alvarez/null-ls.nvim', config = [[require('lewis6991.null-ls')]]},

  {'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-cmdline',
      -- 'dmitmel/cmp-cmdline-history',
      'lukas-reineke/cmp-rg',
      'f3fora/cmp-spell',
      'andersevenrud/cmp-tmux',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- 'ray-x/cmp-treesitter',
    },
    config = [[require('lewis6991.cmp')]]
  },

  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  {'nvim-lua/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-lua/plenary.nvim'
    },
    config = "require'lewis6991.telescope'"
  },

  {'neovim/nvimdev.nvim',
    requires = {'neomake/neomake'}
  },

  {'norcalli/nvim-colorizer.lua', config = [[require('colorizer').setup()]] },

  {'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/playground',
    },
    run = ':TSUpdate',
    config = "require'lewis6991.treesitter'",
  }
}
