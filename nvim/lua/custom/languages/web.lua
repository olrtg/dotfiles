-- NOTE: This is a config file for web related languages like js/ts/html/css and others.

local api = require("custom.api")

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
		opts = {},
	},
	{ "windwp/nvim-ts-autotag", config = true },
	-- { "nvim-treesitter/nvim-treesitter-angular" },
	{ "elgiano/nvim-treesitter-angular", branch = "topic/jsx-fix" }, -- NOTE: until https://github.com/nvim-treesitter/nvim-treesitter-angular/pull/4 is merged
	{ "dmmulroy/tsc.nvim", cmd = { "TSC" }, config = true },
	{ "axelvc/template-string.nvim", config = true },
	{ "olrtg/nvim-rename-state", dev = true },
})

--
-- Emmet
--
require("lspconfig").emmet_language_server.setup({})

--
-- Unocss
--
require("lspconfig").unocss.setup({})

--
-- Angular
--
require("lspconfig").angularls.setup({})

--
-- Linters
--
require("lspconfig").eslint.setup({})

-- api.setup_linters({
-- 	{ command = "stylelint" },
-- })
