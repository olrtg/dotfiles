--
-- Activate LunarVim tailwindcss lsp configuration only
-- if project seems to have a tailwindcss dependency
--
local utils = require("utils")
local project_has_tailwindcss_dependency = function()
	return (vim.fn.glob("tailwind*") ~= "" or utils.is_in_package_json("tailwindcss"))
end

local options = {
	cmd = {
		vim.fn.stdpath("data") .. "/lsp_servers/tailwindcss_npm/node_modules/.bin/tailwindcss-language-server",
		"--stdio",
	},
}

if project_has_tailwindcss_dependency() == true then
	require("lvim.lsp.manager").setup("tailwindcss", options)
end
