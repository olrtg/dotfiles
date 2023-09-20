-- NOTE: This is a config file for web related languages like js/ts/html/css and others.

local api = require("user.utils.api")

api.override_servers({ "tsserver" })

api.install_tools({
  "astro-language-server",
  "css-lsp",
  "html-lsp",
  "prisma-language-server",
  "stylelint",
  "svelte-language-server",
  "tailwindcss-language-server",
  "unocss-language-server",
  "vue-language-server",
})

api.install_parsers({
  "astro",
  "css",
  "graphql",
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
    dir = "~/i/nvim-rename-state",
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
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
})

--
-- nvim-ts-autotag
--
api.setup_plugin("nvim-ts-autotag")

--
-- Emmet
--
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "astro,css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,svelte,typescriptreact,vue",
  callback = function()
    vim.lsp.start({
      cmd = { "emmet-language-server", "--stdio" },
      root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
      -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
      -- **Note:** only the options listed in the table are supported.
      init_options = {
        --- @type string[]
        excludeLanguages = {},
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        syntaxProfiles = {},
        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        variables = {},
      },
    })
  end,
})

---
--- Unocss
---
require("lvim.lsp.manager").setup("unocss")


--
-- Linters
--
api.setup_linters({
  { command = "stylelint" },
})
