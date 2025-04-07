-------------------------------------------
-- 1. BOOTSTRAP PACKER (plugin manager)
-------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim", install_path
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-------------------------------------------
-- 2. PLUGIN INSTALLATION WITH PACKER
-------------------------------------------
-- Reload Neovim whenever you save this file.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- The plugin specification:
require("packer").startup(function(use)
  -- Let packer manage itself.
  use "wbthomason/packer.nvim"

  -------------------------------------------
  -- LSP, Completion & Snippets
  -------------------------------------------
  use "neovim/nvim-lspconfig"           -- Quickstart configs for Nvim LSP
  use "hrsh7th/nvim-cmp"                -- Completion engine
  use "hrsh7th/cmp-nvim-lsp"            -- LSP source for nvim-cmp
  use "hrsh7th/cmp-buffer"              -- Buffer completions
  use "hrsh7th/cmp-path"                -- Path completions
  use "hrsh7th/cmp-cmdline"             -- Cmdline completions
  use "L3MON4D3/LuaSnip"                -- Snippet engine
  use "rafamadriz/friendly-snippets"    -- A collection of snippets
  use "folke/lazydev.nvim"              -- Lazy loading for LSP and completion
  use({
    "stevearc/aerial.nvim",             -- LSP symbol navigation
    config = function()
      require("aerial").setup()
    end,
  })

  -------------------------------------------
  -- Which Key (keybindings helper)
  -- Shows keybindings in a popup
  -------------------------------------------
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }

  -------------------------------------------
  -- Telescope (fuzzy finding)
  -------------------------------------------
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -------------------------------------------
  -- File Explorer (modern replacement for NERDTree)
  ------------------------------------------
  use 'nvim-tree/nvim-web-devicons'
  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" }
  }

  -------------------------------------------
  -- Statusline (modern alternative to vim-airline)
  -------------------------------------------
  use "nvim-lualine/lualine.nvim"

  -------------------------------------------
  -- Git integration
  -------------------------------------------
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }
  use "tpope/vim-fugitive"     -- Git commands within nvim
  use "tpope/vim-rhubarb"      -- Fugitive extension

  -------------------------------------------
  -- Editing enhancements
  -------------------------------------------
  use "windwp/nvim-autopairs"       -- Auto-close brackets, quotes, etc.
  use {
    "nvim-treesitter/nvim-treesitter", -- Better syntax highlighting and more
    run = ":TSUpdate"
  }
  use "lukas-reineke/indent-blankline.nvim" -- Indentation guides
  use "numToStr/Comment.nvim"       -- Easily (un)comment code
  use "tpope/vim-surround"          -- Surround text objects easily

  use({
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    -- requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({
        completions = { lsp = { enabled = true } },
      })
    end,
  })

  use({
    'folke/zen-mode.nvim',
    
  })

  -------------------------------------------
  -- Session/Project Management
  -------------------------------------------
  use "folke/persistence.nvim"      -- Save and restore sessions

  -------------------------------------------
  -- Additional plugins (merged from your old setup)
  -------------------------------------------
  use "dense-analysis/ale"          -- Asynchronous linting (if you still prefer ALE)
  use "thiagoalessio/rainbow_levels.vim"  -- Rainbow parentheses (or levels)
  use "slashmili/alchemist.vim"     -- Elixir support
  use "github/copilot.vim"          -- GitHub Copilot integration
  use "jparise/vim-graphql"         -- GraphQL filetype support
  use "tpope/vim-endwise"           -- Automatically insert "end" in Ruby, etc.
  use "tpope/vim-commentary"        -- Alternative commenting commands (in addition to Comment.nvim)

  -------------------------------------------
  -- Language-Specific Plugins
  -------------------------------------------
  -- Go
  use { "fatih/vim-go", run = ":GoInstallBinaries" }
  -- Ruby
  use "tpope/vim-rails"
  use "tpope/vim-rake"
  use "tpope/vim-projectionist"
  use "thoughtbot/vim-rspec"
  use "ecomba/vim-ruby-refactoring"
  -- JavaScript/TypeScript
  use "leafgarland/typescript-vim"
  use "HerringtonDarkholme/yats.vim"
  -- Python
  use "davidhalter/jedi-vim"
  use "raimon49/requirements.txt.vim"
  -- HTML/CSS/etc.
  use "hail2u/vim-css3-syntax"
  use "tpope/vim-haml"
  use "mattn/emmet-vim"

  -----------------
  -- Colorscheme --
  -----------------
  use "morhetz/gruvbox"

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)

-------------------------------------------
-- 3. GENERAL SETTINGS & OPTIONS
-------------------------------------------
local o, opt = vim.o, vim.opt

-- Use true colors and a nice color scheme.
vim.o.termguicolors = true
vim.opt.background = "dark"
vim.cmd("colorscheme gruvbox")


-- Line numbers & relative numbers.
o.number = true
o.relativenumber = true

-- Mouse and clipboard support.
o.mouse = "a"
o.clipboard = "unnamedplus"

-- Search settings.
o.ignorecase = true
o.smartcase = true

-- Tabs & indentation.
opt.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.backspace = "indent,eol,start"

-- Splitting windows.
o.splitbelow = true
o.splitright = true

-- Disable wrapping.
o.wrap = false

-- Leader key.
vim.g.mapleader = " "

-- Setup paths
vim.g.node_host_prog = '~/.local/share/mise/installs/node/latest/lib/node_modules'
vim.g.copilot_node_command = '~/.local/share/mise/installs/node/latest/bin/node'
vim.g.python3_host_prog = '~/.local/share/mise/installs/python/3.13.1/bin/python3'

-------------------------------------------
-- 4. SETUP / CONFIGURE INSTALLED PLUGINS
-------------------------------------------

-- Lualine (statusline)
require("lualine").setup({
  options = {
    section_separators = "",
    component_separators = ""
  }
})

-- Zen Mode (distraction-free writing)
require("zen-mode").setup({
  window = {
    width = 0.8,
    height = 0.9,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      foldcolumn = "0",
      list = false,
    },
  },
  plugins = {
    tmux = { enabled = true },
    kitty = { enabled = true, font = "+8" },
  }
})
-- Make sure CTRL+W Z toggles Zen Mode
vim.keymap.set("n", "<C-w>z", function()
  require("zen-mode").toggle()
end, { desc = "Toggle Zen Mode" })

-- Nvim-tree (file explorer)
require("nvim-tree").setup({})

-- Telescope keymaps with mnemonics
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp tags" })

local telescope = require("telescope")
telescope.load_extension("fzf")
telescope.load_extension("aerial")

-- Gitsigns (git integration)
require("gitsigns").setup()

-- nvim-autopairs (auto-closing pairs)
require("nvim-autopairs").setup{}

-- Treesitter (better syntax highlighting)
require("nvim-treesitter.configs").setup({
  -- Either install all available parsers…
  ensure_installed = { "bash", "lua", "python", "ruby", "go", "javascript", "vue" },
  -- …or specify a list, e.g.:
  -- ensure_installed = { "bash", "c", "cpp", "lua", "python", "rust", "go" },
  highlight = { enable = true },
  indent = { enable = true }
})

-- Indent-blankline (indentation guides)
vim.cmd [[
  highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
  highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
  highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
]]
-- Make sure Vim shows list characters
vim.opt.list = true

require "ibl".setup {
  indent = { char = "┆" },
  whitespace = { remove_blankline_trail = true },
}
-- Comment.nvim (easy commenting)
require("Comment").setup()

-- Persistence (session management)
require("persistence").setup({
  options = { "buffers", "curdir", "tabpages", "winsize" },
})

-- LSP
local lspconfig = require("lspconfig")
lspconfig.ruby_lsp.setup{}
lspconfig.pyright.setup({
  cmd = { "mise", "x", "node@23", "--", "pyright-langserver", "--stdio" }
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Show hover information" })
vim.keymap.set("n", "gD", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })

-- which-key
local wk = require("which-key")
wk.add({
  { "<leader>f", group = "Telescope" },
  { "<leader>r", group = "Ruby refactoring" },
  { "<leader>rap", ":RAddParameter<cr>", desc = "Add parameter" },
  { "<leader>rcpc", ":RConvertPostConditional<cr>", desc = "Convert post-conditional" },
  { "<leader>rel", ":RExtractLet<cr>", desc = "Extract let (RSpec)" },
  { "<leader>rec", ":RExtractConstant<cr>", desc = "Extract constant" },
  { "<leader>relv", ":RExtractLocalVariable<cr>", desc = "Extract local variable" },
  { "<leader>rit", ":RInlineTemp<cr>", desc = "Inline temp" },
  { "<leader>rrlv", ":RRenameLocalVariable<cr>", desc = "Rename local variable" },
  { "<leader>rriv", ":RRenameInstanceVariable<cr>", desc = "Rename instance variable" },
  { "<leader>rem", ":RExtractMethod<cr>", desc = "Extract method" },
})

-------------------------------------------
-- 5. CUSTOM KEYMAPPINGS & AUTOCMDS
-------------------------------------------

-- Navigation keymaps with mnemonics
vim.keymap.set("n", "{", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "}", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<C-n>", ":bprevious<CR>:redraw<CR>:ls<CR>", { desc = "[N]avigate to previous buffer" })
vim.keymap.set("n", "<F8>", ":AerialToggle<CR>", { desc = "Toggle code outline" })

-- Create a command to remove trailing whitespace.
vim.api.nvim_create_user_command("FixWhitespace", function()
  vim.cmd("%s/\\s\\+$//e")
end, {})

-- Autocmd: Restore last cursor position when reopening a file.
-- Unless in COMMIT_EDITMSG, which is used by Git.
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = {"*"},
  callback = function()
    if vim.fn.expand("%:t") == "COMMIT_EDITMSG" then
      -- For COMMIT_EDITMSG, always start at the top.
      vim.api.nvim_win_set_cursor(0, {1, 0})
      return
    end
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

