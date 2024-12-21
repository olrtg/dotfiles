local lspconfig = require("lspconfig")

local lspconfig_defaults = lspconfig.util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	"force",
	lspconfig_defaults.capabilities,
	require("blink.cmp").get_lsp_capabilities(lspconfig_defaults.capabilities)
)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup()
require("java").setup()
---@diagnostic disable-next-line: missing-fields
require("mason-lspconfig").setup({
	handlers = {
		function(server_name) lspconfig[server_name].setup({}) end,

		eslint = function()
			lspconfig.eslint.setup({
				settings = {
					rulesCustomizations = {
						-- set all eslint errors/warnings to show as warnings
						{ rule = "*", severity = "warn" },
					},
				},
				on_attach = function(_, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
		end,

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

		vtsls = function()
			local location = require("mason-registry").get_package("vue-language-server"):get_install_path()
				.. "/node_modules/@vue/language-server"
			lspconfig.vtsls.setup({
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue", -- volar uses the typescript language server in hybrid mode
				},
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = location,
									languages = { "vue" },
									configNamespace = "typescript",
									enableForWorkspaceTypeScriptVersions = true,
								},
							},
						},
					},
					typescript = {
						tsserver = { maxTsServerMemory = 8092 },
						inlayHints = {
							enumMemberValues = { enabled = true },
						},
					},
					javascript = {
						tsserver = { maxTsServerMemory = 8092 },
						inlayHints = {
							enumMemberValues = { enabled = true },
						},
					},
				},
			})
		end,

		emmet_language_server = function() end,
	},
})

lspconfig.emmet_language_server.setup({
	cmd = { "emmet-language-server", "--stdio" },
})

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
