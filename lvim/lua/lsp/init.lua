-- sumneko_lua
require("lsp.lua")

-- jsonls
require("lsp.json")

-- emmet_ls
require("lsp.emmet")

-- tailwindcss
require("lsp.tailwindcss")

lvim.lsp.automatic_servers_installation = false

local utils = require("utils")
local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")

local project_has_prettier_config = function()
	local hasprettier = (vim.fn.glob(".prettierrc*") ~= "" or utils.is_in_package_json("prettier"))
	-- print("Project does has prettier configured? " .. tostring(hasprettier))
	return hasprettier
end

local formatters_table = {
	{ command = "eslint_d" },
	{ command = "stylua" },
	{
		exe = "shfmt",
		filetypes = {
			"sh",
			"shell",
			"bash",
			"zsh",
		},
	},
}

if project_has_prettier_config() == true then
	table.insert(formatters_table, {
		command = "prettier",
		extra_args = { "--no-semi", "--single-quote", "--trailing-comma=all", "--arrow-parens=avoid" },
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"markdown",
			"svelte",
			"typescript",
			"typescriptreact",
			"vue",
			"yaml",
		},
	})
else
	table.insert(formatters_table, {
		command = "prettier",
		filetypes = {
			"html",
			"json",
			"markdown",
			"yaml",
		},
	})
end

local linters_table = {
	{ command = "eslint_d" },
	{ command = "jsonlint" },
	{
		command = "shellcheck",
		filetypes = {
			"sh",
			"shell",
			"bash",
			"zsh",
		},
	},
	{
		exe = "markdownlint",
		filetype = {
			"markdown",
		},
	},
	{
		exe = "write-good",
		filetype = {
			"markdown",
		},
	},
	{
		exe = "stylelint",
		filetypes = {
			"css",
			"scss",
			"sass",
			"less",
		},
	},
}

formatters.setup(formatters_table)
linters.setup(linters_table)

-- Disable formatting capability of tsserver and jsonls
-- as we use prettier and/or eslint_d to format/fix
lvim.lsp.on_attach_callback = function(client, _)
	if client.name ~= "tsserver" and client.name ~= "jsonls" then
		return
	end

	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end
