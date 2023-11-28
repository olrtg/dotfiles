local M = {}

M.store = {
	plugins = {},
	parsers = {},
}

--- @param plugins table
--- @param opts table
function M.setup_lazy(plugins, opts)
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end

	vim.opt.rtp:prepend(lazypath)

	local all_plugins = vim.list_extend(M.store.plugins, plugins)
	require("lazy").setup(all_plugins, opts)
end

function M.install_plugins(plugins)
	vim.list_extend(M.store.plugins, plugins)
end

function M.install_parsers(parsers)
	vim.list_extend(M.store.parsers, parsers)
end

return M
