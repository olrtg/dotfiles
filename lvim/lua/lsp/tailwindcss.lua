--
-- Activate LunarVim tailwindcss lsp configuration only
-- if project seems to have a tailwindcss dependency
--
local utils = require("utils")

local options = {
	cmd = {
		vim.fn.stdpath("data") .. "/lsp_servers/tailwindcss_npm/node_modules/.bin/tailwindcss-language-server",
		"--stdio",
	},
}

if utils.project_has_tailwindcss_dependency() == true then
	require("lvim.lsp.manager").setup("tailwindcss", options)
end
