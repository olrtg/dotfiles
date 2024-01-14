local M = {}

M.store = {
	plugins = {},
	parsers = {},
	tools = {},
	formatters = {},
	linters = {},
	code_actions = {},
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

---Install plugins using Lazy
---@param plugins table<table>
function M.install_plugins(plugins)
	vim.list_extend(M.store.plugins, plugins)
end

--- Install parsers from Tree-sitter
--- @param parsers table<string>
function M.install_parsers(parsers)
	vim.list_extend(M.store.parsers, parsers)
end

--- Install LSPs, formatters, linters and DAPs from Mason
--- @param tools table<string>
function M.install_tools(tools)
	vim.list_extend(M.store.tools, tools)
end

--- Inject formatters with null-ls
--- @param formatters table<table>
function M.setup_formatters(formatters)
	vim.list_extend(M.store.formatters, formatters)
end

--- Inject linters with null-ls
--- @param linters table<table>
function M.setup_linters(linters)
	vim.list_extend(M.store.linters, linters)
end

--- Inject code actions with null-ls
--- @param code_actions table<table>
function M.setup_code_actions(code_actions)
	vim.list_extend(M.store.code_actions, code_actions)
end

return M
