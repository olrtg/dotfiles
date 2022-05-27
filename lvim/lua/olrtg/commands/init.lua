-- Provide .env file for worktrees
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		local parent_env_exists = vim.fn.filereadable("./../.env") ~= 0
		local env_exists = vim.fn.filereadable("./.env") ~= 0

		if parent_env_exists and not env_exists then
			vim.api.nvim_command("!cp ./../.env ./.env")
			vim.notify(
				"Found a parent .env file. Copied!",
				vim.lsp.log_levels.SUCCESS,
				{ title = "Dotenv provisioning" }
			)
		end
	end,
	desc = "Provide .env files",
})

-- Remove kitty padding
local kitty = vim.api.nvim_create_augroup("kitty", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.api.nvim_command("silent! !kitty @ set-spacing padding=0")
	end,
	group = kitty
})

vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	callback = function()
		vim.api.nvim_command("silent! !kitty @ set-spacing padding=20")
	end,
	group = kitty
})
