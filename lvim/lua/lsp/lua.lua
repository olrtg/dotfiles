local sumneko_opts = {
	settings = {
		Lua = {
			diagnostics = { globals = { "hs" } },
		},
	},
}

require("lvim.lsp.manager").setup("sumneko_lua", sumneko_opts)
