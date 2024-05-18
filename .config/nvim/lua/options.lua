local call = vim.call
local cmd = vim.cmd
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.o
local opt = vim.opt

g.Illuminate_delay = 500
o.cursorline = true
o.expandtab = true
o.ignorecase = true
o.mouse = "a"
o.spell = false
o.shiftwidth = 2
o.showmatch = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.undofile = true
opt.scrolloff = 4
opt.signcolumn = "yes"
opt.wrap = false

-- Disable unused plugins
g.loaded_matchit = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_tarPlugin = 1
g.loaded_gzip = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_shada_plugin = 1
g.loaded_spellfile_plugin = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_remote_plugins = 1

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

-- Update highlight groups for Treesitter.
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Variable" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Variable" })
vim.api.nvim_set_hl(0, "DiagnosticOk", { link = "String" })

-- Line numbers
-- Do not set them by default, but <leader>n toggle them
-- Cycle through relativenumber * number, number (only), and no numbering
cmd([[
  function! CycleNumbering()
    if exists('+relativenumber')
      execute {
          \ '00': 'set relativenumber   | set number',
          \ '01': 'set norelativenumber | set number',
          \ '10': 'set norelativenumber | set nonumber',
          \ '11': 'set norelativenumber | set number', }[&number . &relativenumber]
    else
      set number!<CR>
    endif
  endfunction
  nmap <leader>n :call CycleNumbering()<CR>
]])
