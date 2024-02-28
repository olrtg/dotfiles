vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "Podfile syntax highlight (useful for React Native)",
	pattern = "Podfile,*.podspec",
	command = "set filetype=ruby",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "Brewfile syntax highlight",
	pattern = "Brewfile,.Brewfile",
	command = "set filetype=ruby",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Open help in vertical split",
	pattern = { "*.txt" },
	callback = function()
		if vim.o.filetype == "help" then
			vim.cmd.wincmd("L")
		end
	end,
})
