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
				add = "<leader>sa", -- Add surrounding in Normal and Visual modes
				delete = "<leader>sd", -- Delete surrounding
				replace = "<leader>sr", -- Replace surrounding
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({})
		end,
	},
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
	{ "karb94/neoscroll.nvim", opts = {
		easing_function = "quadratic",
	} },
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			files = {
				fd_opts = [[--color=never --type f --follow --ignore]],
				rg_opts = [[--color=never --files --follow --ignore]],
			},
		},
	},
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
	{ "norcalli/nvim-colorizer.lua", event = "BufEnter" },
	{ "numToStr/Comment.nvim", lazy = false, opts = {} },
	{ "ntpeters/vim-better-whitespace", event = "BufEnter" },
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			lazy = true,
			config = function()
				require("nvim-treesitter.configs").setup({
					textobjects = {
						select = {
							enable = true,
							-- Automatically jump forward to textobj, similar to targets.vim
							lookahead = true,
							keymaps = {
								-- You can use the capture groups defined in textobjects.scm
								["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
								["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

								["am"] = {
									query = "@function.outer",
									desc = "Select outer part of a method/function definition",
								},
								["im"] = {
									query = "@function.inner",
									desc = "Select inner part of a method/function definition",
								},

								["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
								["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

								["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
								["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },
							},
						},
					},
				})
			end,
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			---@type TSConfig
			---@diagnostic disable-next-line: missing-fields
			opts = {
				highlight = { enable = true },
				indent = { enable = true },
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
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			}
			treesitter.setup(opts)
		end,
	},
	{ "ojroques/nvim-osc52", event = "BufEnter" },
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
					bash = { "shfmt" },
					javascript = { { "prettierd", "prettier" } },
					lua = { "stylua" },
					sh = { "shfmt" },
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
	{ "tpope/vim-abolish", event = "BufEnter" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{ "vimwiki/vimwiki" },

	-- Completion
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },

			appearance = {
				nerd_font_variant = "mono",
			},
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"basedpyright",
				"clangd",
				"gopls",
				"rust_analyzer",
			},
		},
	},
	{ "neovim/nvim-lspconfig" },
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
