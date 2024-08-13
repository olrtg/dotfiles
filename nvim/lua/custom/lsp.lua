local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp_zero.on_attach(function(_, bufnr)
	-- keybindings are listed here:
	-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/api-reference.md#default_keymapsopts
	lsp_zero.default_keymaps({ buffer = bufnr, exclude = { "<F2>", "<F3>", "<F4>" } })
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action)
end)

lsp_zero.set_sign_icons({
	error = "",
	warn = "",
	hint = "",
	info = "",
})

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup()
require("java").setup()
require("mason-lspconfig").setup({
	handlers = {
		function(server_name) lspconfig[server_name].setup({}) end,

		lua_ls = function()
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
		end,

		jsonls = function()
			lspconfig.jsonls.setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
		end,

		yamlls = function()
			lspconfig.yamlls.setup({
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

		jdtls = function()
			lspconfig.jdtls.setup({
				settings = {
					java = {
						configuration = {
							runtimes = {
								{ name = "JavaSE-20", path = "~/.asdf/installs/java/adoptopenjdk-20.0.2+9" },
								{ name = "JavaSE-11", path = "~/.asdf/installs/java/adoptopenjdk-11.0.20+8" },
								{ name = "JavaSE-1.8", path = "~/.asdf/installs/java/zulu-8.72.0.17" },
							},
						},
						format = {
							settings = {
								url = "~/eclipse-java-stoplight-style.xml",
								profile = "StoplightStyle",
							},
						},
					},
				},
			})
		end,

		tsserver = lsp_zero.noop,
		emmet_language_server = lsp_zero.noop,
	},
})

require("lspconfig").emmet_language_server.setup({
	cmd = { "emmet-language-server", "--stdio" },
})

require("typescript-tools").setup({
	handlers = {
		-- ["textDocument/rename"] = require("nvim-rename-state").rename_handler,
	},
	settings = {
		complete_function_calls = true,
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
