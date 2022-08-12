-- overriding default plugin configs!

local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "toml",
    "markdown",
    "bash",
    "lua",
  },
}

M.mason = {
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",

    -- web
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "emmet-ls",
    "json-lsp",

    -- shell
    "shfmt",
    "shellcheck",
  },
}

return M
