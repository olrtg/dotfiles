local sumneko_opts = {
	settings = {
		Lua = {
			diagnostics = { globals = { "hs" } },
			workspace = {
				library = {
					"/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/",
					"~/.hammerspoon/Spoons/EmmyLua.spoon/annotations",
				},
			},
		},
	},
}

require("lvim.lsp.manager").setup("sumneko_lua", sumneko_opts)
