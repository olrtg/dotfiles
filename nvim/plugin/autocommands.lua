vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function() vim.highlight.on_yank({ higroup = "Visual" }) end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	desc = "Podfile syntax highlight (useful for React Native)",
	pattern = "Podfile,*.podspec",
	command = "set filetype=ruby",
})

vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{ desc = "Brewfile syntax highlight", pattern = "Brewfile,.Brewfile", command = "set filetype=ruby" }
)

vim.api.nvim_create_autocmd(
	{ "BufNewFile", "BufRead" },
	{ desc = "JSONC support for vscode files", pattern = "*/.vscode/*.json", command = "set filetype=jsonc" }
)

vim.api.nvim_create_autocmd("FileType", {
	desc = "Enables treesitter and adds keybinds for incremental selection",
	callback = function(ev)
		if vim.bo[ev.buf].buftype ~= "" then
			return
		end

		pcall(vim.treesitter.start, ev.buf)

		vim.keymap.set({ "n", "v" }, "<CR>", function() vim.treesitter.select("parent") end, { buffer = ev.buf })
		vim.keymap.set("v", "<BS>", function() vim.treesitter.select("child") end, { buffer = ev.buf })
	end,
})
