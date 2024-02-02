local api = {}

---Install LSPs, formatters, linters and DAPs from Mason
---@param tools table<string>
function api.install_tools(tools)
  vim.list_extend(require("user.utils.states").mason_ensure_installed, tools)
end

---Install parsers from Tree-sitter
---@param parsers table<string>
function api.install_parsers(parsers)
  vim.list_extend(lvim.builtin.treesitter.ensure_installed, parsers)
end

---Install plugins using LunarVim's plugin manager
---@param plugins table<table>
function api.install_plugins(plugins)
  vim.list_extend(lvim.plugins, plugins)
end

---Override LunarVim LSPs that should not be automatically configured
---@param servers table<string>
function api.override_servers(servers)
  vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, servers)
end

---Inject formatters with null-ls
---@param formatters table<table>
function api.setup_formatters(formatters)
  local null_ls_formatters = require("lvim.lsp.null-ls.formatters")
  null_ls_formatters.setup(formatters)
end

---Inject linters with null-ls
---@param linters table<table>
function api.setup_linters(linters)
  local null_ls_linters = require("lvim.lsp.null-ls.linters")
  null_ls_linters.setup(linters)
end

---Inject code actions with null-ls
---@param code_actions table<table>
function api.setup_code_actions(code_actions)
  local null_ls_code_actions = require("lvim.lsp.null-ls.code_actions")
  null_ls_code_actions.setup(code_actions)
end

---Better plugin loading with reduced boilerplate
---@param name string
---@param setup? table
---@param callback? fun(plugin: table)
function api.setup_plugin(name, setup, callback)
  local ok, plugin = pcall(require, name)

  if not ok then
    vim.notify(name .. " not found!", vim.log.levels.WARN)
    return
  end

  if setup then
    plugin.setup(setup)
  else
    plugin.setup()
  end

  if callback then
    callback(plugin)
  end
end

return api
