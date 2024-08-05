local conform = require("conform")

conform.setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 5000,
		lsp_format = "fallback",
	},
	formatters = {
		sqlfluff = {
			args = { "fix", "--dialect=postgres", "-" },
		},
	},
	formatters_by_ft = {
		["lua"] = { "stylua" },

		["go"] = { "goimports", "gofumpt" },

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
