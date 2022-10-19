--------------------------------------------------------------------------------

-- NeoVim Configuration

--------------------------------------------------------------------------------

---------------------------------------
-- Globals
---------------------------------------

local call = vim.call
local cmd = vim.cmd
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.o
local opt = vim.opt

---------------------------------------
-- Packer and plugins
---------------------------------------

require("plugins")

-- Speed up loading of Lua modules
local ok, impatient = pcall(require, "impatient")
if not ok then
	print("Failed to load impatient.nvim")
	return
end

---------------------------------------
-- Settings
---------------------------------------

g.mapleader = " "
g.vimsyn_embed = "l"
g.Illuminate_delay = 500
o.cursorline = true
o.expandtab = true
o.ignorecase = true
o.mouse = "a"
o.shiftwidth = 2
o.showmatch = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.undofile = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.signcolumn = "yes"

-- Reload config the right way
vim.api.nvim_exec(
	[[
  augroup ReloadConfig
    autocmd!
    autocmd BufWritePost init.lua,plugins.lua luafile %
  augroup END
]],
	false
)

o.background = "light"
cmd([[colorscheme solarized8]])

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

-- Toggle search highlight
cmd([[ nnoremap <silent><expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n" ]])

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

---------------------------------------
-- Plugins
---------------------------------------

require("plugins")

-- Fixes background color issues
cmd([[ set t_RB= ]])

-- Fixes Tmux background color issues
cmd([[
  if exists('$TMUX')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  endif
]])

cmd([[ highlight Comment cterm=italic gui=italic ]])

-- kamykn/spelunker.vim
o.spell = false
g.enable_spelunker_vim = 1
-- Spell check only for words in buffer
g.spelunker_check_type = 2
g.spelunker_disable_email_checking = 1
g.spelunker_disable_account_name_checking = 1
g.spelunker_disable_acronym_checking = 1
-- Important: this must come after setting the color scheme,
-- otherwise the colors are off
cmd([[
  highlight SpelunkerSpellBad cterm=underline ctermfg=247
  highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE
  hi clear SpelunkerSpellBad
  hi SpelunkerSpellBad cterm=underline
]])

-- mhinz/vim-signify
g.signify_vcs_list = { "hg", "git" }
g.signify_sign_change = "*"
g.signify_sign_delete = "-"

-- junegunn/fzf.vim
cmd([[
  let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  let g:fzf_preview_window = ['up:60%', 'ctrl-/']

  " Rg
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

  " Buff
  command! -bang Buffers
    \ call fzf#vim#buffers(fzf#vim#with_preview(), <bang>0)
]])

-- nvim-treesitter/nvim-treesitter
local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

treesitter.setup({
	ensure_installed = {
		"bash",
		"c",
		"comment",
		"cpp",
		"css",
		"dart",
		"go",
		"html",
		"java",
		"javascript",
		"jsdoc",
		"json",
		"kotlin",
		"lua",
		"proto",
		"python",
		"r",
		"regex",
		"rust",
		"toml",
		"typescript",
		"yaml",
		"yang",
	},
	highlight = {
		enable = true,
		disable = {},
	},
})

require("lsp")

require("diagnostics")

require("neoscroll").setup({
	easing_function = "quadratic",
})

require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 20
		elseif term.direction == "vertical" then
			return vim.api.nvim_win_get_width("%") / 2
		end
	end,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_terminals = false,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	float_opts = {
		border = "rounded",
		--    width = function()
		--      return vim.api.nvim_win_get_width("%") - 25
		--    end,
		--    height = function()
		--      return vim.api.nvim_win_get_height("%") - 25
		--    end,
		winblend = 20,
		highlights = {
			border = "Comment",
			background = "Normal",
		},
	},
})

-- jose-elias-alvarez/null-ls.nvim
require("null-ls").setup({
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.shfmt,
		require("null-ls").builtins.formatting.prettier.with({
			filetypes = { "css", "html", "json", "markdown", "yaml" },
		}),
	},
})

-- kyazdani42/nvim-tree.lua
require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})

cmd("command! LspLog view" .. vim.lsp.get_log_path())

---------------------------------------
-- Status line
---------------------------------------

-- hoob3rt/lualine.nvim
local function progress()
	return [[%p%%]]
end
sections = { lualine_a = { hello } }
require("lualine").setup({
	options = {
		theme = "tokyonight",
		component_separators = { "|", "|" },
	},
	sections = {
		lualine_x = { "fileformat", "encoding", "filetype" },
		lualine_y = { progress },
	},
})

---------------------------------------
-- Mappings
---------------------------------------

-- Automatically copy from + into system clipboard
cmd([[ autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif ]])

require("mappings")

-- Load local lua configuration if present
if vim.fn.filereadable(os.getenv("HOME") .. "/.config/nvim/lua/local.lua") ~= 0 then
	require("local")
end
