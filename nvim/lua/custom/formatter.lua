local conform = require("conform")

conform.setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 5000,
		lsp_format = "fallback",
	},
	formatters = {
		prettier = {
			require_cwd = true,
		},
		sqlfluff = {
			args = { "fix", "--dialect=postgres", "-" },
		},
	},
	formatters_by_ft = {
		["lua"] = { "stylua" },

		["go"] = { "goimports", "gofumpt" },

		["sh"] = { "shfmt" },
		["sql"] = { "sqlfluff" },
	},
})
