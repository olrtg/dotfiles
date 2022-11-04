-- emmet_ls
require("olrtg.lsp.emmet")

-- bashls
require("olrtg.lsp.bash")

lvim.lsp.automatic_servers_installation = false

local utils = require("olrtg.utils")
local code_actions = require("lvim.lsp.null-ls.code_actions")
local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")

local project_has_prettier_config = function()
  return (vim.fn.glob("{.,}prettier*") ~= "" or utils.is_in_package_json("prettier"))
end

local project_has_eslint_config = function()
  return (vim.fn.glob(".eslintrc*") ~= "" or utils.is_in_package_json("eslint"))
end

-- Formatters
local formatters_table = {
  { command = "stylua" },
  { command = "gofumpt" },
  {
    command = "shfmt",
    filetypes = {
      "sh",
      "shell",
      "bash",
      "zsh",
    },
  },
  {
    command = "markdownlint",
    filetype = {
      "markdown",
    },
  },
}

if project_has_prettier_config() == true then
  table.insert(formatters_table, {
    command = "prettierd",
    filetypes = {
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "markdown",
      "svelte",
      "typescript",
      "typescriptreact",
      "vue",
      "yaml",
    },
  })
else
  table.insert(formatters_table, {
    command = "prettierd",
    extra_args = { "--no-semi", "--single-quote", "--trailing-comma=all", "--arrow-parens=avoid" },
    filetypes = {
      "html",
      "json",
      "markdown",
      "yaml",
    },
  })
end

if project_has_eslint_config() == true then
  table.insert(formatters_table, { command = "eslint_d" })
end

if utils.project_has_tailwindcss_dependency() == true then
  table.insert(formatters_table, { command = "rustywind" })
end

-- Linters
local linters_table = {
  { command = "hadolint" },
  { command = "jsonlint" },
  {
    command = "shellcheck",
    filetypes = {
      "sh",
      "shell",
      "bash",
      "zsh",
    },
  },
  { command = "markdownlint", extra_args = { "--disable", "MD013" } },
  { command = "write-good" },
  {
    command = "stylelint",
    filetypes = {
      "css",
      "scss",
      "sass",
      "less",
    },
  },
}

if project_has_eslint_config() == true then
  table.insert(linters_table, { command = "eslint_d" })
else
  table.insert(linters_table, { command = "tsc", filetypes = { "typescript" } })
end

local code_actions_table = {
  { command = "eslint_d" },
  { command = "refactoring" },
}

code_actions.setup(code_actions_table)
formatters.setup(formatters_table)
linters.setup(linters_table)

-- Disable formatting capability of tsserver and jsonls
-- as we use prettier and/or eslint_d to format/fix
lvim.lsp.on_attach_callback = function(client, _)
  if client.name ~= "tsserver" and client.name ~= "jsonls" then
    return
  end

  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end
