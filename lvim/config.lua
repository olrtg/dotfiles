-- Some local utils beforehand
local utils = require("user.utils")

local project_has_prettier_config = function()
  return (vim.fn.glob("{.,}prettier*") ~= "" or utils.is_in_package_json("prettier"))
end

local project_has_eslint_config = function()
  return (vim.fn.glob(".eslintrc*") ~= "" or utils.is_in_package_json("eslint"))
end

-- Lvim config
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 5000
lvim.lsp.diagnostics.virtual_text = false
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.alpha.active = false

-- Treesitter
lvim.builtin.treesitter.ensure_installed = {
  "astro",
  "bash",
  "css",
  "html",
  "java",
  "javascript",
  "json",
  "lua",
  "markdown",
  "prisma",
  "ruby",
  "svelte",
  "toml",
  "tsx",
  "typescript",
  "yaml",
}

lvim.builtin.treesitter.textobjects = {
  select = {
    enable = true,
    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@conditional.outer",
      ["ic"] = "@conditional.inner",
      ["aC"] = "@class.outer",
      ["iC"] = "@class.inner",
    },
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>a"] = "@parameter.inner",
    },
    swap_previous = {
      ["<leader>A"] = "@parameter.inner",
    },
  },
}

-- LSPs
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver", "dartls" })

require("lvim.lsp.manager").setup("emmet_ls")

-- Formatters
local formatters = require("lvim.lsp.null-ls.formatters")
local formatters_table = {
  { command = "shfmt" },
  { command = "stylua" },
  { command = "black" },
}

if project_has_prettier_config() == true then
  table.insert(formatters_table, { command = "prettierd" })
else
  table.insert(formatters_table, {
    command = "prettierd",
    extra_args = { "--no-semi", "--single-quote", "--trailing-comma=all", "--arrow-parens=avoid" },
  })
end

if
  utils.project_has_tailwindcss_dependency() == true
  and utils.is_in_package_json("prettier-plugin-tailwindcss") == false
then
  table.insert(formatters_table, { command = "rustywind" })
end

-- Linters
local linters = require("lvim.lsp.null-ls.linters")
local linters_table = {
  { command = "hadolint" },
  { command = "markdownlint", extra_args = { "--disable", "MD013", "MD041" } },
  { command = "proselint" },
  { command = "shellcheck" },
  { command = "stylelint" },
  { command = "tsc" },
  { command = "flake8" },
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
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" },
  { "folke/lsp-colors.nvim" },
  { "felipec/vim-sanegx", event = "BufRead" },
  { "nvim-treesitter/nvim-treesitter-textobjects", before = "nvim-treesitter" },

  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("user.plugins").typescript_setup()
    end,
  },

  {
    "akinsho/flutter-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("user.plugins").flutter_tools_setup()
      require("telescope").load_extension("flutter")
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("user.plugins").mason_installer_setup()
    end,
  },

  {
    "nvim-treesitter/playground",
    event = "BufRead",
    config = function()
      lvim.builtin.which_key.mappings["T"]["p"] = { "<cmd>TSPlaygroundToggle<cr>", "Playground" }
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup()
      lvim.builtin.which_key.mappings["gy"] =
        { "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", "Gitlinker" }
    end,
  },

  {
    "petertriho/cmp-git",
    dependencies = "nvim-lua/plenary.nvim",
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
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
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

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup()
      lvim.builtin.which_key.mappings["n"] = {
        name = "Neogen",
        c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
        f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
        t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
        F = { "<cmd>lua require('neogen').generate({ type = 'file'})<CR>", "File Documentation" },
      }
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup()
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    event = { "BufRead", "BufNew" },
    config = function()
      require("user.plugins").lsp_signature_setup()
    end,
  },

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  -- Copilot
  { "github/copilot.vim", enabled = false },

  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          plugin_manager_path = os.getenv("LUNARVIM_RUNTIME_DIR") .. "/site/pack/packer",
        })
      end, 800)
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- My own plugins
  {
    dir = "~/code/nvim-rename-state",
    -- enabled = false,
  },
}

-- Keybinds
vim.keymap.set("i", "jk", "<ESC>", { silent = true })

lvim.keys.normal_mode["<C-a>"] = "ggVG" -- select everything in a buffer
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"

lvim.builtin.which_key.mappings["/"] = { '<cmd>let @/=""<cr>', "No Highlight" }
lvim.builtin.which_key.mappings["S"] = { '<cmd>lua require("persistence").load()<cr>', "Last session" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope flutter commands<cr>", "Flutter" }

lvim.builtin.which_key.vmappings["s"] = { [["sy:let @/=@s<CR>cgn]], "Search/Replace" }
lvim.builtin.which_key.vmappings["l"] =
  { name = "LSP", a = { "<Esc><cmd>lua vim.lsp.buf.range_code_action()<cr>", "Code Action" } }

lvim.builtin.which_key.vmappings["m"] = {
  name = "Markdown",
  b = { 'c**<C-r>"**<esc>', "Bold" },
  c = { 'c```<cr><C-r>"```<esc>', "Code Block" },
  e = { 'c`<C-r>"`<esc>', "Inline Code" },
  i = { 'c_<C-r>"_<esc>', "Italic" },
  s = { 'c~<C-r>"~<esc>', "Strike-through" },
}

-- Load autocommands
require("user.autocmds")
