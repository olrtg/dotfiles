local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {
	b.diagnostics.checkmake,
	b.diagnostics.eslint_d,
	b.diagnostics.hadolint,
	b.diagnostics.markdownlint.with({ extra_args = { "--disable", "MD013" } }),
	b.diagnostics.shellcheck,
	b.diagnostics.yamllint,

	b.formatting.prettierd.with({
		extra_args = { "--no-semi", "--single-quote", "--trailing-comma=all", "--arrow-parens=avoid" },
	}),
	b.formatting.shfmt,
	b.formatting.stylua,
}

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = function(client, bufnr)
		if client.resolved_capabilities.document_formatting then
			require("custom.autocmds").format_on_save(bufnr)
		end
	end,
})
