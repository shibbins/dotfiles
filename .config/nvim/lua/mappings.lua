local map_opts = { noremap = true, silent = true, nowait = true }

-- Misc
vim.keymap.set("n", ";", ":", map_opts)
vim.keymap.set("i", "jk", "<Esc>", map_opts)
vim.keymap.set("n", "<CR>", ":noh<CR>", map_opts)
vim.keymap.set("n", "<Esc>", ":noh<CR>", map_opts)

-- Yanking
vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)

-- Explore files
vim.keymap.set("n", "<Leader>ef", "<cmd>e .<CR>", map_opts)
vim.keymap.set("n", "<Leader>el", "<cmd>e %:h/<CR>", map_opts)

-- Find
vim.keymap.set("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true, desc = "Find Buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true, desc = "Find Files" })
vim.keymap.set(
	"n",
	"<leader>fl",
	"<cmd>lua require('fzf-lua').files({ cwd = vim.fn.expand('%:h/')})<CR>",
	{ silent = true, desc = "Find Local files" }
)
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('fzf-lua').grep()<CR>", { silent = true, desc = "Find with Grep" })
vim.keymap.set(
	"n",
	"<leader>fh",
	"<cmd>lua require('fzf-lua').oldfiles()<CR>",
	{ silent = true, desc = "Find files in History" }
)

vim.keymap.set("n", "<Leader>l", ":Lazy<CR>", map_opts)

-- Movement
vim.keymap.set("n", "<C-h>", "<C-w>h", map_opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", map_opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", map_opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", map_opts)

-- Diaganostics
vim.keymap.set("n", "<Leader>xx", "<Cmd>Trouble<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>xd", "<Cmd>Trouble document_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>xl", "<Cmd>Trouble loclist<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>xq", "<Cmd>Trouble quickfix<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<Cmd>Trouble lsp_references<CR>", { silent = true, noremap = true })
