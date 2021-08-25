local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  if vim.fn.input("Download Packer? (y for yes): ") ~= "y" then
    return
  end

  print("Downloading packer.nvim...")
  print(vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  )))
end

vim.cmd[[augroup plugins | autocmd! | augroup END]]

-- Reload plugins.lua
vim.cmd[[autocmd plugins BufWritePost plugins.lua lua package.loaded["lewis6991.plugins"] = nil; require("lewis6991.plugins")]]

-- Recompile lazy loaders
vim.cmd[[autocmd plugins BufWritePost plugins.lua PackerCompile]]

local init = {
  'wbthomason/packer.nvim',

  'nanotee/luv-vimdocs',
  'wsdjeg/luarefvim',

  'lewis6991/github_dark.nvim',

  {'justinmk/vim-dirvish', config = "require'lewis6991.dirvish'"},

  'tpope/vim-commentary',
  'tpope/vim-unimpaired',
  'tpope/vim-repeat',
  'tpope/vim-eunuch',
  'tpope/vim-surround',
  'tpope/vim-fugitive',

  {'AndrewRadev/bufferize.vim',
    cmd = 'Bufferize',
    config = function()
      vim.g.bufferize_command = 'enew'
      vim.cmd('autocmd vimrc FileType bufferize setlocal wrap')
    end
  },

  'vim-scripts/visualrepeat',

  -- Highlight the current search result
  -- 'timakro/vim-searchant',
  {'PeterRincker/vim-searchlight', config = function()
    vim.cmd[[highlight default link Searchlight SearchCurrent]]
  end},

  {'folke/trouble.nvim', config = [[require('trouble').setup()]]},

  --- Filetype plugins ---
  {'tmux-plugins/vim-tmux', ft = 'tmux'  },
  {'derekwyatt/vim-scala' , ft = 'scala' },
  {'cespare/vim-toml'     },
  {'zinit-zsh/zinit-vim-syntax', ft = 'zsh'},
  'martinda/Jenkinsfile-vim-syntax',
  'teal-language/vim-teal',

  'tmhedberg/SimpylFold',

  {'lewis6991/foldsigns.nvim',
    config = function()
      require'foldsigns'.setup{
        exclude = {'GitSigns.*'}
      }
    end
  },

  'dietsche/vim-lastplace',

  'christoomey/vim-tmux-navigator',

  'ryanoasis/vim-devicons',
  'powerman/vim-plugin-AnsiEsc',

  {'neapel/vim-bnfc-syntax',
    config = function()
      -- Argh, why don't syntax plugins ever set commentstring!
      vim.cmd[[autocmd vimrc FileType bnfc setlocal commentstring=--%s]]
      -- This syntax works pretty well for regular BNF too
      vim.cmd[[autocmd vimrc BufNewFile,BufRead *.bnf setlocal filetype=bnfc]]
    end
  },

  'wellle/targets.vim',
  'michaeljsmith/vim-indent-object',

  {'whatyouhide/vim-lengthmatters', config = function()
    vim.g.lengthmatters_highlight_one_column = 1
  end},

  'rhysd/conflict-marker.vim',

  {'lewis6991/spaceless.nvim', config = [[require('spaceless').setup()]]},

  'bogado/file-line', -- Open file:line

  {'junegunn/vim-easy-align',
    keys = 'ga',
    config = function()
      vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
      vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
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

  'simrat39/symbols-outline.nvim',

  {'neovim/nvim-lspconfig',
    requires = {
      'kabouzeid/nvim-lspinstall',
      'scalameta/nvim-metals',
    },
    config = "require'lewis6991.lsp'"
  },

  {'jose-elias-alvarez/null-ls.nvim',
    config = [[require('lewis6991.null-ls')]]
  },

  {'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lua',
      { 'andersevenrud/compe-tmux', branch = 'cmp' }
    },
    config = [[require('lewis6991.cmp')]]
  },

  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  {'nvim-lua/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    },
    config = "require'lewis6991.telescope'"
  },

  {'lewis6991/cleanfold.nvim', config = "require('cleanfold').setup()" },

  'whiteinge/diffconflicts',

  {'dstein64/nvim-scrollview', config = function()
    vim.g.scrollview_current_only = 1
    vim.g.scrollview_column = 1
  end},

  {'pwntester/octo.nvim', config=function()
    require"octo".setup()
  end, keys = ':'},

  -- 'mhinz/vim-signify',
  -- 'airblade/vim-gitgutter',
  {'~/projects/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.cmd[[cabbrev g Gitsigns]]
      require('gitsigns').setup{
        debug_mode = true,
        signs = {
          add       = {text = '┃' },
          change    = {text = '┃' },
          delete    = {linehl = 'NormalNC'},
          topdelete = {linehl = 'NormalNC'},
        },
        keymaps = {
          -- Default keymap options
          noremap = true,

          ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
          ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

          ['n <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
          ['v <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
          ['n <leader>hS'] = '<cmd>Gitsigns stage_buffer<CR>',
          ['n <leader>hu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
          ['n <leader>hr'] = '<cmd>Gitsigns reset_hunk<CR>',
          ['v <leader>hr'] = '<cmd>Gitsigns reset_hunk<CR>',
          ['n <leader>hR'] = '<cmd>Gitsigns reset_buffer<CR>',
          ['n <leader>hp'] = '<cmd>Gitsigns preview_hunk<CR>',
          ['n <leader>hb'] = '<cmd>Gitsigns blame_line true <CR>',
          ['n <leader>hB'] = '<cmd>Gitsigns toggle_current_line_blame<CR>',
          ['n <leader>hd'] = '<cmd>Gitsigns diffthis<CR>',
          ['n <leader>hD'] = '<cmd>Gitsigns diffthis ~<CR>',

          ['n m'] = '<cmd>Gitsigns dump_cache<CR>',
          ['n M'] = '<cmd>Gitsigns debug_messages<CR>',

          ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
        },
        preview_config = {
          border = 'rounded',
        },
        current_line_blame_formatter_opts = {
          relative_time = true
        },
        current_line_blame_opts = {
          delay = 200
        },
        count_chars = {'₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉', ['+']='₊'},
        _refresh_staged_on_update = false,
        word_diff = true,
      }
    end
  },

  {'~/projects/spellsitter.nvim', config = [[require('spellsitter').setup()]] },

  {'norcalli/nvim-colorizer.lua', config = [[require('colorizer').setup()]] },

  {'nvim-treesitter/nvim-treesitter',
    requires = {
      'romgrk/nvim-treesitter-context',
      'nvim-treesitter/playground',
    },
    run = ':TSUpdate',
    config = "require'lewis6991.treesitter'",
  },

  'euclidianAce/BetterLua.vim',

  -- {'romgrk/barbar.nvim',
  --   requires = { 'kyazdani42/nvim-web-devicons' },
  --   config = function()
  --     vim.g.bufferline = vim.tbl_extend('force', vim.g.bufferline or {}, {
  --       closable = false
  --     })
  --     vim.api.nvim_set_keymap('n', '<Tab>'  , ':BufferNext<CR>'    , {silent=true})
  --     vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferPrevious<CR>', {silent=true})
  --   end
  -- },

  {'akinsho/bufferline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require("bufferline").setup{
        options = {
          show_buffer_close_icons = false,
          show_close_icon = false,
        }
      }
      vim.api.nvim_set_keymap('n', '<Tab>'  , ':BufferLineCycleNext<CR>', {noremap=true, silent=true})
      vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', {noremap=true, silent=true})
    end
  }

}

local packer = require('packer')

packer.startup{init,
  config = {
    -- profile = {
    --   enable = false,
    --   threshold = 1
    -- },
    display = {
      open_cmd = 'vnew \\[packer\\]',
      prompt_border = 'rounded'
    }
  }
}

return packer
