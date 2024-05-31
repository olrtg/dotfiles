require("conform").setup({
	formatters_by_ft = {
		["lua"] = { "stylua" },

		["javascript"] = { "prettierd" },
		["typescript"] = { "prettierd" },
		["javascriptreact"] = { "prettierd" },
		["typescriptreact"] = { "prettierd" },
		["vue"] = { "prettierd" },
		["css"] = { "prettierd" },
		["scss"] = { "prettierd" },
		["less"] = { "prettierd" },
		["html"] = { "prettierd" },
		["json"] = { "prettierd" },
		["jsonc"] = { "prettierd" },
		["yaml"] = { "prettierd" },
		["markdown"] = { "prettierd" },
		["markdown.mdx"] = { "prettierd" },
		["graphql"] = { "prettierd" },
		["handlebars"] = { "prettierd" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
