-- NOTE: This is a config file for web related languages like js/ts/html/css and others.

local api = require("user.utils.api")

api.override_servers({ "tsserver" })

api.install_tools({
  "angular-language-server",
  "astro-language-server",
  "css-lsp",
  "eslint",
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
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_file_preferences = {
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
  { "windwp/nvim-ts-autotag" },
  -- { "nvim-treesitter/nvim-treesitter-angular" },
  { "elgiano/nvim-treesitter-angular", branch = "topic/jsx-fix" }, -- NOTE: until https://github.com/nvim-treesitter/nvim-treesitter-angular/pull/4 is merged
  {
    dir = "~/i/nvim-rename-state",
    -- enabled = false,
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
  pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",
  callback = function()
    vim.lsp.start({
      name = "emmet",
      cmd = { "emmet-language-server", "--stdio" },
      root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
      -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
      -- **Note:** only the options listed in the table are supported.
      init_options = {
        --- @type string[]
        excludeLanguages = {},
        --- @type string[]
        extensionsPath = {},
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

--
-- Unocss
--
require("lvim.lsp.manager").setup("unocss")

--
-- Angular
--
require("lvim.lsp.manager").setup("angularls")

--
-- Linters
--
require("lvim.lsp.manager").setup("eslint")

api.setup_linters({
  { command = "stylelint" },
})
