local M = {}

M.typescript_setup = function()
  -- https://github.com/jose-elias-alvarez/typescript.nvim#setup
  -- https://github.com/ChristianChiarulli/lvim/blob/master/lua/user/lsp/languages/js-ts.lua
  require("typescript").setup({
    debug = false,
    go_to_source_definition = {
      fallback = true,
    },
    server = {
      on_attach = require("lvim.lsp").common_on_attach,
      on_init = require("lvim.lsp").common_on_init,
      capabilities = require("lvim.lsp").common_capabilities(),
    },
  })
end

M.mason_installer_setup = function()
  require("mason-tool-installer").setup({
    ensure_installed = {
      "astro-language-server",
      "bash-language-server",
      "css-lsp",
      "dockerfile-language-server",
      "editorconfig-checker",
      "emmet-ls",
      "eslint-lsp",
      "eslint_d",
      "hadolint",
      "html-lsp",
      "json-lsp",
      "jsonlint",
      "lua-language-server",
      "markdownlint",
      "prettierd",
      "prisma-language-server",
      "proselint",
      "shellcheck",
      "shfmt",
      "stylelint-lsp",
      "stylua",
      "tailwindcss-language-server",
      "taplo",
      "typescript-language-server",
      "vim-language-server",
      "yaml-language-server",
    },
  })
end

return M
