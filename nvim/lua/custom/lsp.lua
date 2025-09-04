local lspconfig = require("lspconfig")

local lspconfig_defaults = lspconfig.util.default_config

if not vim.g.forcing_myself_to_learn then
	lspconfig_defaults.capabilities = require("blink.cmp").get_lsp_capabilities(lspconfig_defaults.capabilities)
end

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup()
---@diagnostic disable-next-line: missing-fields
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "vtsls", "eslint", "jsonls", "yamlls", "ruby_lsp" },
})

do -- https://github.com/mason-org/mason-lspconfig.nvim/issues/113#issuecomment-1471346816
	local registry = require("mason-registry")

	for _, pkg_name in ipairs({ "stylua", "prettier" }) do
		local ok, pkg = pcall(registry.get_package, pkg_name)
		if ok then
			if not pkg:is_installed() then
				pkg:install()
			end
		end
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
		vim.keymap.set("n", "grr", builtin.lsp_references, opts)
		vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
		vim.keymap.set("n", "gO", builtin.lsp_document_symbols, opts)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "gD", builtin.lsp_type_definitions, opts)
	end,
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},

	virtual_text = {
		prefix = " 󱓻",
		suffix = " ",
	},
})

vim.lsp.inlay_hint.enable()
