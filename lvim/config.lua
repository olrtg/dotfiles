--
-- LunarVim
--
lvim.format_on_save.enabled = false
lvim.lsp.diagnostics.virtual_text = false
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.alpha.active = false
lvim.colorscheme = "tokyonight"

--
-- Plugins
--
lvim.plugins = {
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" },
  { "folke/lsp-colors.nvim" },
  { "imsnif/kdl.vim" },
  { "felipec/vim-sanegx", event = "BufRead" },
  { "folke/tokyonight.nvim" },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
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
    "axelvc/template-string.nvim",
    config = function()
      require("template-string").setup()
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
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },

  {
    dir = "~/code/nvim-i18n",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("nvim-i18n").setup()
    end,
    enabled = false,
  },
}

--
-- Keybindings
--
vim.keymap.set("i", "jk", "<ESC>", { silent = true })

lvim.keys.normal_mode["<C-a>"] = "ggVG" -- select everything in a buffer
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"

lvim.builtin.which_key.vmappings["s"] = { [["sy:let @/=@s<CR>cgn]], "Search/Replace" }

-- BUG: This doesn't work as expected
lvim.builtin.which_key.vmappings["l"] = { name = "LSP", a = { vim.lsp.buf.code_action, "Code Action" } }

--
-- Modules
--
require("user.autocommands")

require("user.languages.docker")
require("user.languages.flutter")
require("user.languages.lua")
require("user.languages.markdown")
require("user.languages.python")
require("user.languages.serialized")
require("user.languages.shell")
require("user.languages.web")

require("user.tooling.eslint")
require("user.tooling.prettier")

require("user.plugins.colorizer")
require("user.plugins.copilot")
require("user.plugins.mason")
require("user.plugins.openingh")
require("user.plugins.persistence")
require("user.plugins.refactoring")
require("user.plugins.treesitter")
