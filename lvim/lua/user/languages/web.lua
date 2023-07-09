-- NOTE: This is a config file for web related languages like js/ts/html/css and others.

local api = require("user.utils.api")

api.override_servers({ "tsserver" })

api.install_tools({
  "astro-language-server",
  "css-lsp",
  "html-lsp",
  "prisma-language-server",
  "rustywind",
  "stylelint-lsp",
  "svelte-language-server",
  "tailwindcss-language-server",
  "unocss-language-server",
  "vue-language-server",
})

api.install_parsers({
  "astro",
  "css",
  "html",
  "javascript",
  "prisma",
  "scss",
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
    -- settings = {
    --   typescript = {
    --     inlayHints = {
    --       includeInlayParameterNameHints = "all",
    --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --       includeInlayFunctionParameterTypeHints = false,
    --       includeInlayVariableTypeHints = true,
    --       includeInlayPropertyDeclarationTypeHints = true,
    --       includeInlayFunctionLikeReturnTypeHints = true,
    --       includeInlayEnumMemberValueHints = true,
    --     },
    --   },
    --   javascript = {
    --     inlayHints = {
    --       includeInlayParameterNameHints = "all",
    --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
    --       includeInlayFunctionParameterTypeHints = false,
    --       includeInlayVariableTypeHints = true,
    --       includeInlayPropertyDeclarationTypeHints = true,
    --       includeInlayFunctionLikeReturnTypeHints = true,
    --       includeInlayEnumMemberValueHints = true,
    --     },
    --   },
    -- },
  },
})

--
-- nvim-ts-autotag
--
api.setup_plugin("nvim-ts-autotag")

--
-- Emmet
--
lvim.autocommands = {
  {
    "FileType",
    {
      pattern = "astro,css,eruby,html,htmldjango,javascript,javascriptreact,less,pug,sass,scss,svelte,typescriptreact,vue,php",
      callback = function()
        vim.lsp.start({
          cmd = { "emmet-language-server", "--stdio" },
          root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
          init_options = {
            --- @type table<string, any> https://docs.emmet.io/customization/preferences/
            preferences = {},
            --- @type "always" | "never" Defaults to `"always"`
            showExpandedAbbreviation = "always",
            --- @type boolean Defaults to `false`
            showAbbreviationSuggestions = true,
            --- @type boolean Defaults to `false`
            showSuggestionsAsSnippets = false,
            --- @type table<string, any> https://docs.emmet.io/customization/syntax-profiles/
            syntaxProfiles = {},
            --- @type table<string, string> https://docs.emmet.io/customization/snippets/#variables
            variables = {},
            --- @type string[]
            excludeLanguages = {},
          },
        })
      end,
    },
  },
}

---
--- Unocss
---
require("lvim.lsp.manager").setup("unocss")

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
