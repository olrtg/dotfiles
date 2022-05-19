-- Provide .env file for worktrees
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		local parent_env_exists = vim.fn.filereadable("./../.env") ~= 0
		local env_exists = vim.fn.filereadable("./.env") ~= 0

		if parent_env_exists and not env_exists then
			vim.api.nvim_command("!cp ./../.env ./.env")
			print("Found a parent .env file. Copied!")
		end
	end,
	desc = "Provide .env files",
})
