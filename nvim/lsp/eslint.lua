return {
	settings = {
		rulesCustomizations = {
			-- set all eslint errors/warnings to show as warnings
			{ rule = "*", severity = "warn" },
		},
	},
	on_attach = function(_, bufnr)
		-- fix all fixable eslint errors on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
}
