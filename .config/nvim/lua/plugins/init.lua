return {
	-- Themes
	{ "folke/tokyonight.nvim" },
	{
		"ishan9299/nvim-solarized-lua",
		priority = 1000,
		config = function()
			vim.o.background = "light"
			vim.cmd.colorscheme("solarized")
		end,
	},

	-- General
	{ "akinsho/toggleterm.nvim", branch = "main", opts = {} },
	{ "christoomey/vim-tmux-navigator" },
	{
		"echasnovski/mini.surround",
		version = false,
		opts = {
			mappings = {
				add = "za", -- Add surrounding in Normal and Visual modes
				delete = "zd", -- Delete surrounding
				replace = "zr", -- Replace surrounding
			},
		},
	},
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{ "numToStr/Comment.nvim", lazy = false, opts = {} },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		-- stylua: ignore
		keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
   },
	},
	{ "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
		end,
	},
	{ "karb94/neoscroll.nvim", opts = {
		easing_function = "quadratic",
	} },
	{ "norcalli/nvim-colorizer.lua", event = "BufEnter" },
	{ "ntpeters/vim-better-whitespace", event = "BufEnter" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"comment",
				"cpp",
				"css",
				"go",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"proto",
				"python",
				"rust",
				"sql",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
				"yang",
			},
			highlight = {
				enable = true,
				disable = {},
			},
		},
	},
	{ "ojroques/nvim-osc52", event = "BufEnter" },
	{ "tpope/vim-abolish", event = "BufEnter" },
	{
		"hoob3rt/lualine.nvim",
		opts = {
			options = {
				theme = "solarized",
				component_separators = { "|", "|" },
			},
			sections = {
				lualine_x = { "fileformat", "encoding", "filetype" },
				lualine_y = { [[%p%%]] },
			},
		},
	},
	{ "vimwiki/vimwiki" },
	{ "RRethy/vim-illuminate", event = "BufEnter" },
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
				formatters_by_ft = {
					javascript = { { "prettierd", "prettier" } },
					lua = { "stylua" },
					sh = { "shfmt" },
					shell = { "shfmt" },
					zsh = { "shfmt" },
				},
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- Completion
	-- { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	-- { "williamboman/mason.nvim" },
	-- { "neovim/nvim-lspconfig" },
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/nvim-cmp" },
	-- { "L3MON4D3/LuaSnip" },
	-- { "rafamadriz/friendly-snippets" },
	-- { "saadparwaiz1/cmp_luasnip" },
	-- { "onsails/lspkind-nvim" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
			-- "L3MON4D3/LuaSnip",
			-- "saadparwaiz1/cmp_luasnip",
			"lukas-reineke/lsp-format.nvim",
			"onsails/lspkind-nvim",
			"rafamadriz/friendly-snippets",
		},
	},
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"clangd",
				"gopls",
				"basedpyright",
				"rust_analyzer",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettier",
				"shfmt",
				"stylua",
			},
		},
	},
}
