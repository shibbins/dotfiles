--------------------------------------------------------------------------------

-- NeoVim Configuration

--------------------------------------------------------------------------------

require("lazy-nvim")
require("lazy").setup("plugins", { change_detection = {
	notify = false,
} })

require("options")
require("mappings")

require("lsp")
require("diagnostics")

-- Load local lua configuration if present
if vim.fn.filereadable(os.getenv("HOME") .. "/.config/nvim/lua/local.lua") ~= 0 then
	require("local")
end
