-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[[ Package manager ]]] {{{

-- Bootstrap
do -- {{{
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end -- }}}

require('lazy').setup({
  -- Colorscheme
  { -- {{{
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'moon',
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = 'dark',
        floats = 'dark',
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight-moon')
    end,
    init = function()
      vim.o.background = 'dark'
    end,
  },
  'axvr/photon.vim',
  'Luxed/ayu-vim',
  'arzg/vim-colors-xcode',
  -- }}}

  -- Statusline
  { -- {{{
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'nightfly',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'fileformat', 'encoding', 'filetype'},
        lualine_y = {'%3p%%'},
        lualine_z = {'location'},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    },
    config = function(_, opts)
      local custom_theme = require('lualine.themes.nightfly')
      custom_theme.normal.b.bg   = '#3b4059'
      custom_theme.insert.b.bg   = '#3b4059'
      custom_theme.visual.b.bg   = '#3b4059'
      custom_theme.replace.b.bg  = '#3b4059'
      --custom_theme.command.b.bg  = '#3b4059'
      custom_theme.inactive.b.bg = '#3b4059'

      opts.options.theme = custom_theme
      require('lualine').setup(opts)
    end
  }, -- }}}

  -- LSP
  { -- {{{
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'LspAttach',
        opts = {
          align = {
            bottom = true,
            right = true,
          },
        },
      },

      'folke/neodev.nvim',
    },
  }, -- }}}

  -- Autocompletion
  { -- {{{
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet engine
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      --'hrsh7th/cmp-cmdline',
      --'hrsh7th/cmp-calc',
      --'hrsh7th/cmp-emoji',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  }, -- }}}

  -- Treesitter
  -- {{{
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
    name = 'treesitter-playground',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  -- }}}

  -- Telescope
  -- {{{
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable('make') == 1
    end,
  },
  -- }}}

  -- Detect tabstop and shiftwidth
  { 'tpope/vim-sleuth', enabled = false },
  {
    'NMAC427/guess-indent.nvim',
    config = true,
  },

  -- Git
  { -- {{{
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', '<cmd>Git<CR>', { desc = '[G]it [S]tatus' })
      vim.keymap.set('n', '<leader>gh', '<cmd>diffget //2<CR>', { desc = '[G]it diff get from left' })
      vim.keymap.set('n', '<leader>gl', '<cmd>diffget //3<CR>', { desc = '[G]it diff get from right' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = require('gitsigns')

        vim.keymap.set('n', '<leader>gp',  gs.prev_hunk,     { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn',  gs.next_hunk,     { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph',  gs.preview_hunk,  { buffer = bufnr, desc = '[P]review [H]unk' })
        vim.keymap.set('n', '<leader>tgl', gs.toggle_linehl, { buffer = bufnr, desc = '[T]oggle [G]it [L]ine highlight' })
      end,
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)

      -- Custom colors
      vim.cmd('highlight GitSignsAdd    guifg=#22AA66 ctermfg=41')
      vim.cmd('highlight GitSignsChange guifg=#FF6600 ctermfg=202')
      vim.cmd('highlight GitSignsDelete guifg=#FF2255 ctermfg=197')
    end,
  },
  {
    'junegunn/gv.vim',
    cmd = 'GV'
  }, -- }}}

  -- Show pending keybinds
  { -- {{{
    'folke/which-key.nvim',
    init =function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  }, -- }}}

  -- Visual line indents
  { -- {{{
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      enabled = true,
      indent = {
        char = '│',
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = {
        enabled = true,
        char = '┊',
        show_start = false,
        show_end = false,
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
    end
  }, -- }}}

  -- "gc" to comment visual regions/lines
  { -- {{{
    'numToStr/Comment.nvim',
    opts = {},
  }, -- }}}

  -- Show colors
  { -- {{{
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
        '*',
        '!sixel',
      })
    end,
  }, -- }}}

  -- Dim code not in scope
  { -- {{{
    'folke/twilight.nvim',
    opts = {
      dimming = {
        alpha = 0.25,
      },
      context = 20,
      treesitter = true,
      exclude = {},
    },
  }, -- }}}

  -- Terminals
  {
    'akinsho/toggleterm.nvim',
    opts = {
      autochdir = true,
      float_opts = {
        border = 'single',
        winblend = 0,
      },
      size = 20,
    },
  },

  -- Git test
  {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
    cmd = {
      'Neogit',
      'NeogitMessages',
    },
  },

  -- Undotree
  { -- {{{
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndoTree' })
    end
  }, -- }}}

  -- VimWiki
  { -- {{{
    'vimwiki/vimwiki',
    cmd = {
      'VimwikiIndex',
      'VimwikiTabIndex',
      'VimwikiUISelect',
    },
    keys = {
      { '<leader>ww', vim.cmd.VimwikiIndex,    desc = 'Vim[W]iki [W] Index'},
      { '<leader>wt', vim.cmd.VimwikiTabIndex, desc = 'Vim[W]iki Index in new [T]ab'},
      { '<leader>ws', '<Plug>VimwikiUISelect', desc = 'Vim[W]iki UI [S]elect'},
    },
    config = function()
      vim.g.vimwiki_list = {{
        path = '~/vimwiki/',
        syntax = 'markdown',
        ext = '.md',
      }}

      -- Remove default mappings
      vim.keymap.del('n', '<leader>wi')
      vim.keymap.del('n', '<leader>w<leader>w')
      vim.keymap.del('n', '<leader>w<leader>t')
      vim.keymap.del('n', '<leader>w<leader>y')
      vim.keymap.del('n', '<leader>w<leader>m')
      vim.keymap.del('n', '<leader>w<leader>i')
    end
  }, -- }}}

  'djpohly/vim-execline',

  'alx741/vinfo',

  'tpope/vim-unimpaired',

  -- TODO: DAP
  --'mfussenegger/nvim-dap',
  --'rcarriga/nvim-dap-ui',
  --'theHamsta/nvim-dap-virtual-text',

  -- Emmet
  { -- {{{
    'mattn/emmet-vim',
    init = function()
      vim.g.user_emmet_mode = 'i'
      vim.g.user_emmet_leader_key = '<c-h>'
    end,
  }, -- }}}

  -- F#
  { -- {{{
    'ionide/Ionide-vim',
    ft = {
      'fs',
      'fsi',
      'fsx',
    },
    config = function()
      vim.g['fsharp#fsi_keymap'] = 'custom'
      vim.g['fsharp#fsi_keymap_send']   = '<C-e>'
      vim.g['fsharp#fsi_keymap_toggle'] = '<C-@>'
    end
  }, -- }}}

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
    },
  },

  -- Pretty list for diagnostics, quickfix and location lists
  { -- {{{
    'folke/trouble.nvim',
    opts = {
      icons = false,
      fold_open = 'v',
      fold_closed = '>',
      indent_lines = false,
      signs = {
        error = 'error',
        warning = 'warn',
        hint = 'hint',
        information = 'info',
      },
      use_diagnostic_signs = false,
    },
    config = function(_, opts)
      require('trouble').setup(opts)

      vim.keymap.set('n', '<leader>td', vim.cmd["Trouble document_diagnostics"], { desc = '[T]rouble [D]iagnostics' })
    end,
  }, -- }}}

  -- Highlight stuff with rules
  { -- {{{
    'folke/paint.nvim',
    opts = {
      -- @type PaintHighlight[]
      highlights = {
        {
          filter = { filetype = 'lua' },
          pattern = '%s*%-%-%s*(@%w+)',
          hl = 'Constant',
        },
      },
    },
  }, -- }}}

  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = false,
      columns = {},
      view_options = {
        show_hidden = true,
        natural_order = false,
      },
    },
  },

}, {
  concurrency = 2,
  pills = true,
  install = {
    colorscheme = { 'tokyonight-moon', 'lunaperche' },
  },
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
    wrap = true,
    border = 'single',
  },
}) -- }}}

-- [[ Options ]]
-- {{{

-- No Compatible
vim.o.compatible = false

-- Indentation
vim.o.tabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Splitting
vim.o.splitright = true
vim.o.splitbelow = true

-- Markers
vim.o.foldmethod = 'marker'

-- Listchars
vim.o.list = true
vim.o.listchars = 'tab:>·,trail:-,nbsp:+'

-- Statusline
vim.o.laststatus = 2
vim.o.showmode = false

-- Search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Look
vim.o.guicursor = 'n-v-r:block,i-c:ver10'
vim.o.termguicolors = true
vim.o.colorcolumn = '80'
vim.o.showcmd = true
vim.o.cursorline = true

-- Buffers
vim.o.hidden = true

-- Enable break indent
--vim.o.breakindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Completion menu options
vim.o.completeopt = 'menu,menuone,noselect'

-- Misc
vim.o.scrolloff = 1

vim.o.lazyredraw = true
vim.o.errorbells = false
vim.g.c_syntax_for_h = 1

-- }}}

-- [[ Basic Keymaps ]]

-- Clear
vim.keymap.set('n', '<leader><space>', vim.cmd.nohlsearch, { desc = '[ ] Clear search highlight' })
vim.keymap.set('n', '<leader>c', ':<BS>', { desc = '[C]lear cmdline', silent = true })

-- Make space a no-op
vim.keymap.set({'n','v'}, '<Space>', '<Nop>', { silent = true })

-- Remaps for dealing with word wrap
vim.keymap.set('n', '<c-k>', 'gk', { noremap = true })
vim.keymap.set('n', '<c-j>', 'gj', { noremap = true })

-- Configure Telescope
do -- {{{
  local telescope = require('telescope')
  local builtin   = require('telescope.builtin')

  telescope.setup({
    defaults = {
      borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
  })

  pcall(telescope.load_extension, 'fzf')

  vim.keymap.set('n', '<leader>T', vim.cmd.Telescope, { desc = '[T]elescope select builtin' })

  vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = '[B] Find existing buffers' })
  vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzy search in current buffer' })

  vim.keymap.set('n', '<leader>gf', builtin.git_files,   { desc = 'Search [G]it [F]iles'  })
  vim.keymap.set('n', '<leader>ff', builtin.find_files,  { desc = '[F]ind [F]iles'        })

  vim.keymap.set('n', '<leader>fh', builtin.help_tags,   { desc = '[F]ind [H]elp'         })
  vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics'  })

  vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep,   { desc = '[F]ind by [G]rep'      })
end -- }}}

-- [[ Configure Treesitter ]]
-- {{{
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c', 'cpp',
    'go',
    'lua',
    'python',
    'rust',
    'javascript', 'typescript',
    'vimdoc', 'vim',
    --'comment',
  },
  auto_install = false,

  highlight = { enable = true },
  indent    = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection    = '<C-space>',
      node_incremental  = '<C-space>',
      node_decremental  = '<C-S-Space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
})

-- Additional parsers
do
  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

  parser_config.sixel = {
      install_info = {
          url = 'https://github.com/Dareka826/tree-sitter-sixel',
          files = { 'src/parser.c' },
          branch = 'master',
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
      },
      filetype = 'six',
  }

  parser_config.fsharp = {
    install_info = {
      url = 'https://github.com/Nsidorenco/tree-sitter-fsharp',
      branch = 'develop',
      files = {'src/scanner.cc', 'src/parser.c' },
      generate_requires_npm = true,
      requires_generate_from_grammar = true
    },
    filetype = 'fsharp',
  }
end
-- }}}

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev,  { desc = '[D]iagnostics [N]ext' })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_next,  { desc = '[D]iagnostics [P]revious' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = '[D]iagnostics [F]loat' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[D]iagnostics [Q]uickfixlist' })

-- [[ Configure LSP ]]
-- {{{
-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>gR', vim.lsp.buf.rename, '[G] [R]ename')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  pylsp = {
    pylsp = {
      plugins = {
        pyls_mypy = {
          enabled = true,
          live_mode = false,
        },
        pycodestyle = {
          ignore = {
            'E201',
            'E202',
            'E221',
            'E226',
            'E241',
            'E251',
            'E261',
            'E266',
            'E302',
            'E305',
            'E501',
            'E702',
          },
        },
      },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup({
  override = function(root_dir, library)
    if root_dir:find("/.config/nvim", 1, true) ~= nil then
      library.enabled = true
      library.plugins = true
    end
  end,
})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
require('mason').setup({
  ui = {
    icons = {
      package_installed = '●',
      package_pending = '➜',
      package_uninstalled = '○'
    },
    border = 'single',
  }
})

do
  local mason_lspconfig = require('mason-lspconfig')

  local ensure_installed = {}
  local is_termux = (os.getenv("TERMUX_VERSION") ~= nil)

  if not is_termux then
    ensure_installed = {
      'clangd',
      'lua_ls',
      'pylsp',
    }
  end

  mason_lspconfig.setup({
    ensure_installed = ensure_installed,
  })

  local lspconfig = require('lspconfig')

  local handlers_setup = {
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      })
    end,
  }

  if is_termux then
    handlers_setup['clangd'] = function()
      lspconfig['clangd'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { '/data/data/com.termux/files/usr/bin/clangd' },
      })
    end

    handlers_setup['lua_ls'] = function()
      lspconfig['lua_ls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { '/data/data/com.termux/files/usr/bin/lua-language-server' },
        settings = servers['lua_ls'],
      })
    end

    lspconfig['omnisharp'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { 'omnisharp' },
      settings = servers['omnisharp'],
    })
  end

  if os.getenv('VIRTUAL_ENV') ~= nil then
    handlers_setup['pylsp'] = function()
      lspconfig['pylsp'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { os.getenv('VIRTUAL_ENV') .. '/bin/pylsp' },
        settings = servers['pylsp'],
      })
    end
  end

  mason_lspconfig.setup_handlers(handlers_setup)
end
-- }}}

-- [[ Configure completion ]]
-- {{{
do
  local cmp     = require('cmp')
  local luasnip = require('luasnip')
  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup({})

  cmp.setup({
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-space>'] = cmp.mapping.complete(),

      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs( 4),
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          buffer   = '[buf]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[api]',
          path     = '[path]',
          luasnip  = '[snip]',
        })[entry.source.name] or entry.source.name

        return vim_item
      end
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'buffer' },
      { name = 'path' },
    }),
  })

  -- Luasnip keybinds
  vim.keymap.set({'i','s'}, '<C-u>', function()
      if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
      end
  end, {})

  vim.keymap.set({'i','s'}, '<C-d>', function()
      if luasnip.jumpable(-1) then
          luasnip.jump(-1)
      end
  end, {})

  -- Custom matched chars color
  vim.cmd('hi! link CmpItemAbbrMatch      Statement')
  vim.cmd('hi! link CmpItemAbbrMatchFuzzy Statement')
end
-- }}}

vim.keymap.set('n', '<leader>tt', require('twilight').toggle, { desc = '[T]oggle [T]wilight' })

vim.keymap.set('n', '<leader>pv', vim.cmd.Explore, { desc = '[P]roject [V]iew' })

-- Mouse
vim.keymap.set('n', '<leader>me', function() vim.o.mouse = 'a' end, { desc = '[M]ouse [E]nable' })
vim.keymap.set('n', '<leader>md', function() vim.o.mouse = ''  end, { desc = '[M]ouse [D]isable' })
vim.o.mouse = ''

-- Git in terminal
do -- {{{
  local Terminal = require('toggleterm.terminal').Terminal
  local direction = 'float'
  --local direction = 'horizontal'

  local lazygit = Terminal:new({
    cmd = 'lazygit',
    hidden = true,
    direction = direction,
  })
  local gitui = Terminal:new({
    cmd = 'gitui',
    hidden = true,
    direction = direction,
  })
  local tig = Terminal:new({
    cmd = 'tig',
    hidden = true,
    direction = direction,
  })

  vim.keymap.set('n', '<leader>gl', function() lazygit:toggle() end, { desc = '[G]it [L]azy' })
  vim.keymap.set('n', '<leader>gu', function()   gitui:toggle() end, { desc = '[G]it [U]i'   })
  vim.keymap.set('n', '<leader>gt', function()     tig:toggle() end, { desc = '[G]it [T]ig'  })
end -- }}}

-- Break undo sequence on these
vim.keymap.set('i', ',', ',<c-g>u', { noremap = true })
vim.keymap.set('i', '.', '.<c-g>u', { noremap = true })
vim.keymap.set('i', '!', '!<c-g>u', { noremap = true })
vim.keymap.set('i', '?', '?<c-g>u', { noremap = true })

-- Center and unfold after these:
vim.keymap.set('n', '<c-o>', '<c-o>zzzv', { noremap = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true })

-- System clipboard
vim.keymap.set({'n','v'}, '<leader>pp', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set({'n','v'}, '<leader>yy', '"+y', { desc = 'Yank to system clipboard' })

-- Terminals
vim.keymap.set({'n','t','i'}, [[<c-\>t]], '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { desc = 'Toggle Terminal' })
vim.keymap.set({'n','t','i'}, [[<c-s>]], [[<c-\>t]], { remap = true, desc = 'Toggle Terminal' })

vim.keymap.set('t', [[<c-\>n]], [[<c-\><c-n>]], { desc = 'Escape Terminal' })

-- Oil
vim.keymap.set('n', '+', '<cmd>Oil<cr>', { desc = "Open parent directory" })

-- Syntax for non-standard file extensions
vim.api.nvim_create_augroup('rinbrk_syntax', { clear = true })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  group   = 'rinbrk_syntax',
  pattern = {'*.do'},
  command = 'set ft=sh',
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  group   = 'rinbrk_syntax',
  pattern = {'*.xl'},
  command = 'set ft=execline',
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  group   = 'rinbrk_syntax',
  pattern = {'*.janet'},
  command = 'set ft=janet',
})

-- Neovide
vim.o.guifont = 'Source Code Pro'
vim.g.neovide_cursor_vfx_mode = 'pixiedust'
vim.g.neovide_cursor_vfx_particle_density = 100.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1

-- :W -> :w
vim.cmd("cnoreabbrev W w")

-- vim: ts=2 sts=2 sw=2 et
