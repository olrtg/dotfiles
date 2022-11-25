-- Some local utils beforehand
local utils = require("user.utils")

local project_has_prettier_config = function()
  return (vim.fn.glob("{.,}prettier*") ~= "" or utils.is_in_package_json("prettier"))
end

local project_has_eslint_config = function()
  return (vim.fn.glob(".eslintrc*") ~= "" or utils.is_in_package_json("eslint"))
end

-- Lvim config
lvim.colorscheme = "nord"
vim.g.nord_borders = true

lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 2000
lvim.lsp.diagnostics.virtual_text = false
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "right"

-- Treesitter
lvim.builtin.treesitter.ensure_installed = {
  "astro",
  "bash",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "prisma",
  "toml",
  "tsx",
  "typescript",
  "yaml",
}

-- LSPs
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

require("lvim.lsp.manager").setup("emmet_ls")

-- Formatters
local formatters = require("lvim.lsp.null-ls.formatters")
local formatters_table = {
  { command = "shfmt" },
  { command = "stylua" },
}

if project_has_prettier_config() == true then
  table.insert(formatters_table, { command = "prettierd" })
else
  table.insert(formatters_table, {
    command = "prettierd",
    extra_args = { "--no-semi", "--single-quote", "--trailing-comma=all", "--arrow-parens=avoid" },
  })
end

if utils.project_has_tailwindcss_dependency() == true then
  table.insert(formatters_table, { command = "rustywind" })
end

-- Linters
local linters = require("lvim.lsp.null-ls.linters")
local linters_table = {
  { command = "hadolint" },
  { command = "markdownlint", extra_args = { "--disable", "MD013" } },
  { command = "proselint" },
  { command = "shellcheck" },
  { command = "stylelint" },
  { command = "tsc" },
}

-- Code Actions
local code_actions = require("lvim.lsp.null-ls.code_actions")
local code_actions_table = {
  { command = "proselint" },
  { command = "refactoring" },
  { command = "shellcheck" },
}

-- Loading eslint conditionally
if project_has_eslint_config() == true then
  table.insert(formatters_table, { command = "eslint_d" })
  table.insert(linters_table, { command = "eslint_d" })
  table.insert(code_actions_table, { command = "eslint_d" })
end

-- Final setup
formatters.setup(formatters_table)
linters.setup(linters_table)
code_actions.setup(code_actions_table)

-- Plugins
lvim.plugins = {
  { "shaunsingh/nord.nvim" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "github/copilot.vim" },
  { "felipec/vim-sanegx", event = "BufRead" },
  { "nvim-treesitter/playground", event = "BufRead" },

  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("user.plugins").typescript_setup()
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("user.plugins").mason_installer_setup()
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  },

  {
    "petertriho/cmp-git",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("cmp_git").setup()
    end,
  },

  {
    "benfowler/telescope-luasnip.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("luasnip")
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufRead",
    requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("refactoring").setup({})
    end,
  },

  {
    "axelvc/template-string.nvim",
    config = function()
      require("template-string").setup()
    end,
  },

  -- My own plugins
  {
    "~/code/nvim-rename-state",
    -- disable = true,
    config = function()
      require("nvim-rename-state").setup()
    end,
  },
}

-- Keybinds
vim.keymap.set("i", "jk", "<ESC>", { silent = true })

lvim.keys.normal_mode["<C-a>"] = "ggVG" -- select everything in a buffer
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"

lvim.builtin.which_key.mappings["/"] = { '<cmd>let @/=""<cr>', "No Highlight" }
lvim.builtin.which_key.mappings["gy"] = { "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", "Gitlinker" }

lvim.builtin.which_key.vmappings["s"] = { [["sy:let @/=@s<CR>cgn]], "Search/Replace" }
lvim.builtin.which_key.vmappings["l"] =
  { name = "LSP", a = { "<Esc><cmd>lua vim.lsp.buf.range_code_action()<cr>", "Code Action" } }

-- Load autocommands
require("user.autocmds")
