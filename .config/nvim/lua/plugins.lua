local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })

	-- Performance
	use({ "lewis6991/impatient.nvim" })

	-- General
	use({ "akinsho/toggleterm.nvim", branch = "main" })
	use({ "christoomey/vim-tmux-navigator" })
	use({ "junegunn/fzf", event = "BufEnter", run = "./install --bin" })
	use({ "junegunn/fzf.vim", event = "BufEnter" })
	use({ "ibhagwan/fzf-lua" })
	use({ "kamykn/spelunker.vim", event = "BufEnter" })
	use({ "karb94/neoscroll.nvim" })
	use({ "lukas-reineke/lsp-format.nvim" })
	--	use({ "machakann/vim-sandwich" })
	use({ "mchughj/vim-mercurial", event = "BufEnter" })
	use({ "mhinz/vim-signify" })
	use({ "norcalli/nvim-colorizer.lua", event = "BufEnter" })
	use({ "ntpeters/vim-better-whitespace", event = "BufEnter" })
	use({ "nvim-telescope/telescope.nvim", requires = { { "nvim-lua/plenary.nvim" } } })
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "ojroques/vim-oscyank", event = "BufEnter" })
	use({ "tpope/vim-abolish", event = "BufEnter" })
	use({ "tpope/vim-commentary", event = "BufEnter" })
	use({ "tpope/vim-surround" })
	use({ "hoob3rt/lualine.nvim" })
	use({ "vimwiki/vimwiki" })
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	})
	use({ "RRethy/vim-illuminate", event = "BufEnter" })

	-- Themes
	use({ "folke/tokyonight.nvim" })
	use({ "lifepillar/vim-solarized8" })
	use({ "sainnhe/gruvbox-material" })

	-- Completion
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "neovim/nvim-lspconfig" })
	use({ "onsails/lspkind-nvim" })
	use({ "rafamadriz/friendly-snippets" })
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- Lua
	use({ "euclidianAce/BetterLua.vim" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "nvim-lua/plenary.nvim" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
