local vue_ls_path = vim.fn.expand("$MASON/packages/vue-language-server")
local vue_plugin_path = vue_ls_path .. "/node_modules/@vue/language-server"

return {
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
						location = vue_plugin_path,
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
}
