-- ======================== GENERAL VIM SETTINGS ===========================

vim.o.inccommand = 'nosplit'
-- Show line numbers
vim.wo.number = true
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.breakindent = true
-- Undo history
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'data' .. '/undo'
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
-- Smart-case searching
vim.o.ignorecase = true
vim.o.smartcase = true
-- More responsive UI
vim.o.updatetime = 250
vim.o.timeoutlen = 500
vim.wo.signcolumn = 'yes'
-- Disable vim's builtin netrw directory traverser
vim.g.loaded_netrw = 0
-- Allow interacting with X's clipboard
vim.o.clipboard = 'unnamedplus'
-- Reload file on change
vim.api.nvim_exec([[ autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif ]], false)

-- Spell checker
vim.o.spell = true
vim.o.spelllang = "en_gb"

-- ======================== LAZY PLUGIN MANAGEMENT ===========================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'tpope/vim-fugitive', -- Git commands in nvim
  'SammysHP/vim-heurindent', -- Automatically adjust 'shiftwidth' and 'expandtab'
  'dietsche/vim-lastplace', -- Open cursor at last place in the file
  'ntpeters/vim-better-whitespace', -- Highlight whitespace at end of lines
  'christoomey/vim-tmux-navigator', -- tmux integration
  'tpope/vim-speeddating', -- Increment dates and other things correctly with <C-A>/<C-X>
  'haya14busa/is.vim', -- Slightly tweak incremental searching
  'folke/neoconf.nvim', -- Per-project settings with `.neoconf.json`
  'rust-lang/rust.vim', -- Rust convenience
  'simrat39/rust-tools.nvim',
  'cespare/vim-toml', -- Syntax highlighting for TOML files
  'dstein64/nvim-scrollview', -- Scrollbar
  'nvim-lua/popup.nvim', -- Hopefully temporary popin hack
  -- Colorscheme
  { 'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000, -- load before other plugins
    opts = {
      style = 'darker',
      transparent = 'true'
    },
  },
  -- Add/remove comments with gc
  {'numToStr/Comment.nvim', opts = {} },
  -- Forward (s)/backwards (S) search in visible text
  { 'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  -- Access all the diagnostics with `ga`
  { 'folke/trouble.nvim', dependencies={"nvim-tree/nvim-web-devicons"},
    opts = {
      icons = false,
      fold_open = "v",
      fold_closed = ">",
      indent_lines = false,
      severity = vim.diagnostic.severity.ERROR,
      signs = {
	error = "E",
	warning = "W",
	hint = "H",
	information = "I"
      },
      use_diagnostic_signs = false
    }
  },
  -- Show indentation characters '┊'
  { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup {
        exclude = {
          filetypes = { 'help', 'packer' },
          buftypes = { 'terminal', 'nofile' }
        },
        indent = { char = '┊' },
        scope = { exclude = { language = { "lua" } } },
        whitespace = { highlight = { 'LineNr' } }
     }
   end,
  },
  -- NERDtree-like file browser
  { 'nvim-tree/nvim-tree.lua', dependencies={"nvim-tree/nvim-web-devicons"},
    opts = {
      filters = {
        dotfiles = false,
        exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        adaptive_size = false,
        side = "left",
        width = 30,
        preserve_window_proportions = true,
      },
      git = {
        enable = false,
        ignore = true,
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = false,
        highlight_opened_files = "none",

        indent_markers = {
          enable = false,
        },

        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false,
          },
          padding = "  ",

          glyphs = {
            default = "󰈚",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
              arrow_open = "",
              arrow_closed = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
    }
  },
  -- Show the available key-presses
  { "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  },
  -- Live markdown preview in a browser (needs Node and Yarn to be installed)
  { "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
        cond = function()
          return vim.fn.executable 'node' == 1 and vim.fn.executable 'yarn' == 1
        end,
    ft = { "markdown" },
  },
  -- UI to select things (files, grep results, open buffers...)
  { 'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup{
        defaults = {
          layout_strategy = "flex",
          sorting_strategy = "descending",
          mappings = {
            i = {
              ["<C-d>"] = false,
              ["<C-u>"] = false,
              ["<PageDown>"] = actions.move_to_bottom,
              ["<PageUp>"] = actions.move_to_top,
              ["<C-up>"] = actions.preview_scrolling_up,
              ["<C-down>"] = actions.preview_scrolling_down,
            },
            n = {
              ["<C-d>"] = false,
              ["<C-u>"] = false,
              ["<PageDown>"] = actions.move_to_bottom,
              ["<PageUp>"] = actions.move_to_top,
              ["<C-up>"] = actions.preview_scrolling_up,
              ["<C-down>"] = actions.preview_scrolling_down,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      }
      require('telescope').load_extension('fzf')
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- Status bar (bottom of screen)
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {{
          'filename',
          path=3,
          symbols = {
            modified = '*',
            readonly = '-',
            unnamed = '[No Name]',
            newfile = '[New]',
          }
        }},
        lualine_b = {{'branch', icon=''}, 'diff', 'diagnostics'},
        lualine_c = {},
        lualine_x = {'mode'},
        lualine_y = {'location', 'progress'},
        lualine_z = {'encoding', {'filetype', colored=false}}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_a = {{
          'buffers',
          max_length = function() return vim.o.columns end,
          mode = 2,
          symbols = {
            modified = ' *',
            alternate_file  = '',
            directory = ''
          }
        }},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {}

    }
  },
  -- Add git related info in the signs columns and popups
  { 'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = {
        add = { hl = 'GitGutterAdd', text = '+' },
        change = { hl = 'GitGutterChange', text = '~' },
        delete = { hl = 'GitGutterDelete', text = '_' },
        topdelete = { hl = 'GitGutterDelete', text = '‾' },
        changedelete = { hl = 'GitGutterChange', text = '~' },
      },
    }
  },
  {'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'c', 'cpp', 'css', 'muttrc', 'toml', 'python', 'rust' },
      highlight = {
        enable = true,
        disable = {'latex'},
        -- Currently we have to add Vim's syntax highlighting to avoid every
        -- keyword being highlighted as a spelling error...
        additional_vim_regex_highlighting = true,
      },
      incremental_selection = { enable = true },
      -- Enabling treesitter's indentation currently causes autoindenting to become very wonky.
      -- indent = { enable = true },
      textobjects = { enable = true },
    }
  end,

  },
  'nvim-treesitter/nvim-treesitter-textobjects', -- Extra stuff for treesitter
  { 'romgrk/nvim-treesitter-context', opts = { enable = true }}, -- Auto-collapse code as you scroll
})

vim.cmd [[colorscheme onedark]]

-- ======================== KEY MAPS ===========================
-- nvim-tree
vim.api.nvim_set_keymap('n', '<leader>dt', ':NvimTreeToggle<Cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<leader>df', ':NvimTreeFocus<Cr>', {noremap=true})
-- telescope
vim.api.nvim_set_keymap('', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers({sort_lastused=true, ignore_current_buffer=false, sort_mru=true})<CR>]], { noremap=true, silent=true})
vim.api.nvim_set_keymap('', '<C-m>', [[<cmd>lua require('telescope.builtin').marks({sort_lastused=true, sort_mru=true})<CR>]], { noremap=true, silent=true})
vim.api.nvim_set_keymap('', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files({hidden=true, previewer=true})<CR>]], { noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true, desc = 'Buffer fuzzy find' })
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]], { noremap = true, silent = true, desc = 'Treesitter' })
vim.api.nvim_set_keymap('n', '<leader>sg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true, desc = 'Live grep' })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true, desc = 'Help tags', })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true, desc = 'Tags (current buffer)' })
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true, desc = 'Tags (all)' })
vim.api.nvim_set_keymap('n', '<leader>sw', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true, desc = 'Grep string' })
vim.api.nvim_set_keymap('n', '<leader>s?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true, desc = 'Old files' })
