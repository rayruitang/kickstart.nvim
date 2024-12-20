-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-bibtex.nvim',
      'debugloop/telescope-undo.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        load_extension = {
          'fzf',
          'yank_history',
          'bibtex',
          'lazygit',
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          undo = {
            mappings = {
              i = {
                ['<C-a>'] = require('telescope-undo.actions').yank_additions,
                ['<C-d>'] = require('telescope-undo.actions').yank_deletions,
                ['<C-u>'] = require('telescope-undo.actions').restore,
                -- ["<C-Y>"] = require("telescope-undo.actions").yank_deletions,
                -- ["<C-cr>"] = require("telescope-undo.actions").restore,
                -- alternative defaults, for users whose terminals do questionable things with modified <cr>
              },
              n = {
                ['y'] = require('telescope-undo.actions').yank_additions,
                ['Y'] = require('telescope-undo.actions').yank_deletions,
                ['u'] = require('telescope-undo.actions').restore,
              },
            },
          },
          bibtex = {
            depth = 1,
            -- Depth for the *.bib file
            global_files = { '~/Library/texmf/bibtex/bib/Zotero.bib' },
            -- Path to global bibliographies (placed outside of the project)
            search_keys = { 'author', 'year', 'title' },
            -- Define the search keys to use in the picker
            citation_format = '{{author}} ({{year}}), {{title}}.',
            -- Template for the formatted citation
            citation_trim_firstname = true,
            -- Only use initials for the authors first name
            citation_max_auth = 2,
            -- Max number of authors to write in the formatted citation
            -- following authors will be replaced by "et al."
            custom_formats = {
              { id = 'citet', cite_maker = '\\citet{%s}' },
            },
            -- Custom format for citation label
            format = 'citet',
            -- Format to use for citation label.
            -- Try to match the filetype by default, or use 'plain'
            context = true,
            -- Context awareness disabled by default
            context_fallback = true,
            -- Fallback to global/directory .bib files if context not found
            -- This setting has no effect if context = false
            wrap = false,
            -- Wrapping in the preview window is disabled by default
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[s]earch [h]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[s]earch [k]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[s]earch [f]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[s]earch [s]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[s]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.git_commits, { desc = '[s]earch [g]it History' })
      vim.keymap.set('n', '<leader>sp', '<cmd>Telescope live_grep theme=ivy<CR>', { desc = '[s]earch in [p]roject' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
      vim.keymap.set('n', '<leader>sR', builtin.resume, { desc = '[s]earch [r]esume' })
      vim.keymap.set('n', '<leader>sr', builtin.registers, { desc = '[s]earch [r]egisters' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sc', '<cmd>Telescope bibtex format_string=\\citet{%s}<CR>', { desc = '[s]earch [c]itations' })

      vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[g]it [b]ranches' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[s]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[s]earch [N]eovim files' })

      -- Undo list for the current buffer
      vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<CR>', { desc = '[u]ndo list' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
