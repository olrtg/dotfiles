vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("olrtg-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "Podfile syntax highlight",
	group = vim.api.nvim_create_augroup("olrtg-podfile-syntax", { clear = true }),
	pattern = "Podfile,*.podspec",
	callback = function()
		vim.bo.filetype = "ruby"
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "Brewfile syntax highlight",
	group = vim.api.nvim_create_augroup("olrtg-brewfile-syntax", { clear = true }),
	pattern = "Brewfile,.Brewfile",
	callback = function()
		vim.bo.filetype = "ruby"
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "JSONC support for vscode files",
	group = vim.api.nvim_create_augroup("olrtg-jsonc-syntax", { clear = true }),
	pattern = "*/.vscode/*.json",
	callback = function()
		vim.bo.filetype = "jsonc"
	end,
})
