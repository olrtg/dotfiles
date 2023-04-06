-- NOTE: This is a config file for web related languages like js/ts/html/css and others.

local api = require("user.utils.api")

api.override_servers({ "tsserver" })

api.install_tools({
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

api.install_parsers({
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

api.install_plugins({
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
api.setup_plugin("typescript", {
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

--
-- nvim-ts-autotag
--
api.setup_plugin("nvim-ts-autotag")

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

if project_has_tailwindcss_dependency() and not utils.is_in_package_json("prettier-plugin-tailwindcss") then
  api.setup_formatters({
    { command = "rustywind" },
  })
  return
end

--
-- Linters
--
api.setup_linters({
  { command = "stylelint" },
})
