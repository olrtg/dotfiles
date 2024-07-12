local conform = require("conform")

conform.setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		["lua"] = { "stylua" },

		["javascript"] = { "prettier" },
		["typescript"] = { "prettier" },
		["javascriptreact"] = { "prettier" },
		["typescriptreact"] = { "prettier" },
		["vue"] = { "prettier" },
		["css"] = { "prettier" },
		["scss"] = { "prettier" },
		["less"] = { "prettier" },
		["html"] = { "prettier" },
		["json"] = { "prettier" },
		["jsonc"] = { "prettier" },
		["yaml"] = { "prettier" },
		["markdown"] = { "prettier" },
		["markdown.mdx"] = { "prettier" },
		["graphql"] = { "prettier" },
		["handlebars"] = { "prettier" },

		["sql"] = { "sqlfluff" },
	},
})
