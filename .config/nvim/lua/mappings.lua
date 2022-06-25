local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local map_opts = { noremap = true, silent = true, nowait = true }
map("n", ";", ":", map_opts)
map("i", "jk", "<Esc>", map_opts)

map("n", "<C-n>", ":NvimTreeToggle<CR>", map_opts)

map("n", "<Leader>f", "<cmd>lua require('fzf-lua').files()<CR>", map_opts)
map("n", "<Leader>h", "<cmd>lua require('fzf-lua').oldfiles()<CR>", map_opts)
map("n", "<Leader>g", "<cmd>lua require('fzf-lua').live_grep()<CR>", map_opts)

map("n", "<Leader>tf", "<cmd>lua require('telescope.builtin').find_files()<CR>", map_opts)
map("n", "<Leader>th", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", map_opts)
map("n", "<Leader>tg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", map_opts)

map("n", "<Leader>R", ":source ~/.config/nvim/init.lua<CR>", map_opts)
map("n", "<Leader>.n", ":e ~/.config/nvim/init.lua<CR>", map_opts)
map("n", "<Leader>.t", ":e ~/.tmux.conf<CR>", map_opts)
map("n", "<CR>", ":noh<CR>", map_opts)
map("n", "<Esc>", ":noh<CR>", map_opts)
map("n", "<Leader>x", ":Bdelete<CR>", map_opts)
map("n", "<Leader>or", ":Files %:p:h<CR>", map_opts)
map("n", "<Leader>ob", ":Buffers<CR>", map_opts)
map("n", "<Leader>of", ":FZF<CR>", map_opts)
map("n", "<Leader>tc", ":Colors<CR>", map_opts)
map("n", "<TAB>", ":BufferLineCycleNext<CR>", map_opts)
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", map_opts)
map("n", "<C-h>", "<C-w>h", map_opts)
map("n", "<C-j>", "<C-w>j", map_opts)
map("n", "<C-k>", "<C-w>k", map_opts)
map("n", "<C-l>", "<C-w>l", map_opts)
map("n", "<Leader><C-l>", ":BufferLineMoveNext<CR>", map_opts)
map("n", "<Leader><C-h>", ":BufferLineMovePrev<CR>", map_opts)
map("v", "<Leader>y", '"+y', { noremap = false, silent = true, nowait = true })
map("n", "<Leader>y", 'V"+y', { noremap = false, silent = true, nowait = true })
map("v", "<Leader>/", "gc", { noremap = false, silent = true, nowait = true })
map("n", "<Leader>/", "gcc", { noremap = false, silent = true, nowait = true })
map("n", "<Leader>xx", "<Cmd>Trouble<CR>", { silent = true, noremap = true })
map("n", "<Leader>xw", "<Cmd>Trouble workspace_diagnostics<CR>", { silent = true, noremap = true })
map("n", "<Leader>xd", "<Cmd>Trouble document_diagnostics<CR>", { silent = true, noremap = true })
map("n", "<Leader>xl", "<Cmd>Trouble loclist<CR>", { silent = true, noremap = true })
map("n", "<Leader>xq", "<Cmd>Trouble quickfix<CR>", { silent = true, noremap = true })
map("n", "gR", "<Cmd>Trouble lsp_references<CR>", { silent = true, noremap = true })
