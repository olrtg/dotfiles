-- NOTE: This is a config file for web related languages like js/ts/html/css and others.

--
-- Override server
--
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

--
-- Mason
--
vim.list_extend(require("user.utils.states").mason_ensure_installed, {
  "astro-language-server",
  "css-lsp",
  "emmet-ls",
  "html-lsp",
  "prisma-language-server",
  "rustywind",
  "stylelint-lsp",
  "svelte-language-server",
  "tailwindcss-language-server",
  "vue-language-server",
})

--
-- Treesitter
--
vim.list_extend(lvim.builtin.treesitter.ensure_installed, {
  "astro",
  "css",
  "html",
  "javascript",
  "prisma",
  "svelte",
  "tsx",
  "typescript",
  "vue",
})

--
-- Plugins
--
vim.list_extend(lvim.plugins, {
  { "jose-elias-alvarez/typescript.nvim" },
  { "windwp/nvim-ts-autotag" },
  {
    dir = "~/code/nvim-rename-state",
    -- enabled = false,
  },
})

--
-- typescript.nvim
--
local ok_typescript, typescript = pcall(require, "typescript")

if ok_typescript then
  -- https://github.com/jose-elias-alvarez/typescript.nvim#setup
  -- https://github.com/ChristianChiarulli/lvim/blob/master/lua/user/lsp/languages/js-ts.lua
  typescript.setup({
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
else
  vim.notify("typescript.nvim not found!", vim.log.levels.WARN)
end

--
-- nvim-ts-autotag
--
local ok_autotag, autotag = pcall(require, "nvim-ts-autotag")

if ok_autotag then
  autotag.setup()
else
  vim.notify("nvim-ts-autotag not found!", vim.log.levels.WARN)
end

--
-- Emmet
--
-- TODO: extend this to work with astro and vue files
require("lvim.lsp.manager").setup("emmet_ls")

--
-- Tailwind CSS Formatter
--
local utils = require("user.utils.functions")

local project_has_tailwindcss_dependency = function()
  return (vim.fn.glob("tailwind*")) ~= ""
    or (vim.fn.glob("web/config/tailwind*")) ~= "" -- for redwood
    or utils.is_in_package_json("tailwindcss")
end

local formatters = require("lvim.lsp.null-ls.formatters")

if not project_has_tailwindcss_dependency() and utils.is_in_package_json("prettier-plugin-tailwindcss") then
  return
end

formatters.setup({ { command = "rustywind" } })

--
-- Linters
--
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({ { command = "tsc" }, { command = "stylelint" } })
