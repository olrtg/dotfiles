-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
---@diagnostic disable-next-line: missing-fields
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "vtsls", "eslint", "jsonls", "yamlls", "ruby_lsp" },
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, opts)
		vim.keymap.set("n", "grr", Snacks.picker.lsp_references, opts)
		vim.keymap.set("n", "gi", Snacks.picker.lsp_implementations, opts)
		vim.keymap.set("n", "gO", Snacks.picker.lsp_symbols, opts)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "gD", Snacks.picker.lsp_type_definitions, opts)
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

vim.lsp.enable("emmet_language_server")
vim.lsp.enable("sourcekit")
