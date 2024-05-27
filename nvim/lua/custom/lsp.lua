local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- keybindings are listed here:
	-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/api-reference.md#default_keymapsopts
	lsp_zero.default_keymaps({ buffer = bufnr, exclude = { "<F2>", "<F3>", "<F4>" } })
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
end)

-- technically these are "diagnostic signs"
-- neovim enables them by default.
-- here we are just changing them to fancy icons.
lsp_zero.set_sign_icons({
	error = "",
	warn = "",
	hint = "",
	info = "",
})

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,

		jsonls = function()
			require("lspconfig").jsonls.setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,

		yamlls = function()
			require("lspconfig").yamlls.setup({
				settings = {
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
		end,

		tsserver = lsp_zero.noop,
	},
})

require("typescript-tools").setup({
	settings = {
		tsserver_file_preferences = {
			includeInlayParameterNameHints = false,
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayFunctionParameterTypeHints = false,
			includeInlayVariableTypeHints = false,
			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
			includeInlayPropertyDeclarationTypeHints = false,
			includeInlayFunctionLikeReturnTypeHints = false,
			includeInlayEnumMemberValueHints = true,
		},
	},
})

vim.diagnostic.config({
	virtual_text = {
		prefix = " 󱓻",
		suffix = " ",
	},
})

vim.lsp.inlay_hint.enable()
