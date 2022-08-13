local utils = require("olrtg.utils")
-- Skip configuring emmet language server client if project
-- does not look like a web project
if not utils.is_web_project() then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local options = {
  cmd = { vim.fn.stdpath("data") .. "/lsp_servers/emmet_ls/node_modules/.bin/emmet-ls", "--stdio" },
  capabilities = capabilities,
  filetypes = {
    "html",
    "svelte",
    "vue",
    "javascriptreact",
    "typescriptreact",
    "php",
    "xml",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
  },
  root_dir = function()
    return vim.loop.cwd()
  end,
}

require("lvim.lsp.manager").setup("emmet_ls", options)
