local json_opts = {
	settings = {
		json = { schemas = require("schemastore").json.schemas() },
	},
}

require("lvim.lsp.manager").setup("jsonls", json_opts)
