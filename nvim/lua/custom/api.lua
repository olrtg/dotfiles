local M = {}

M.state = {
	---@type table<string>
	tools = {},
	---@type table<string>
	parsers = {},
	---@type table<string|LazyPluginSpec>
	plugins = {},
}

---Install LSPs, formatters, linters and DAPs from Mason
---@param tools table<string>
function M.install_tools(tools)
	vim.list_extend(M.state.tools, tools)
end

---Install parsers from Tree-sitter
---@param parsers table<string>
function M.install_parsers(parsers)
	vim.list_extend(M.state.parsers, parsers)
end

---Install plugins using LunarVim's plugin manager
---@param plugins table<string|LazyPluginSpec>
function M.install_plugins(plugins)
	vim.list_extend(M.state.plugins, plugins)
end

-- ---Inject formatters with null-ls
-- ---@param formatters table<table>
-- function M.setup_formatters(formatters)
-- 	local null_ls_formatters = require("lvim.lsp.null-ls.formatters")
-- 	null_ls_formatters.setup(formatters)
-- end
--
-- ---Inject linters with null-ls
-- ---@param linters table<table>
-- function M.setup_linters(linters)
-- 	local null_ls_linters = require("lvim.lsp.null-ls.linters")
-- 	null_ls_linters.setup(linters)
-- end
--
-- ---Inject code actions with null-ls
-- ---@param code_actions table<table>
-- function M.setup_code_actions(code_actions)
-- 	local null_ls_code_actions = require("lvim.lsp.null-ls.code_actions")
-- 	null_ls_code_actions.setup(code_actions)
-- end
--
return M
