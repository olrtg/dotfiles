local conform = require("conform")

conform.setup({
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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args) conform.format({ bufnr = args.buf }) end,
})
