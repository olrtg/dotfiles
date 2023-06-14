--
-- LunarVim
--
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 5000
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.alpha.active = false
-- lvim.colorscheme = "tokyonight"

vim.diagnostic.config({ virtual_text = false })
vim.opt.relativenumber = true

--
-- Plugins
--
lvim.plugins = {
  { "imsnif/kdl.vim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" },
  { "tpope/vim-surround" },
  { "tjdevries/cyclist.vim" },
  { "folke/lsp-colors.nvim" },
  { "folke/tokyonight.nvim" },
  { "dmmulroy/tsc.nvim", config = true },
  { "j-hui/fidget.nvim", config = true },
  { "axelvc/template-string.nvim", config = true },
  { "simrat39/symbols-outline.nvim", config = true },
  { "folke/todo-comments.nvim", event = "BufRead", config = true },
  { "inkarkat/vim-AdvancedSorters", dependencies = "inkarkat/vim-ingo-library" },
  { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim", config = true },
  { "chrishrb/gx.nvim", event = { "BufEnter" }, dependencies = { "nvim-lua/plenary.nvim" }, config = true },

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
    "benfowler/telescope-luasnip.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("luasnip")
      lvim.builtin.which_key.mappings["ss"] = { "<cmd>Telescope luasnip<cr>", "Snippets" }
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
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({
  --       api_key_cmd = 'op read "op://Personal/jawpmm6snisueuiboamijysdgq/api key" --no-newline',
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },

  -- NOTE: My plugins in development
  {
    dir = "~/code/nvim-i18n",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = true,
    enabled = true,
  },
}

--
-- Keybindings
--
vim.keymap.set("i", "jk", "<ESC>", { silent = true })

lvim.keys.normal_mode["<C-a>"] = "ggVG" -- select everything in a buffer
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"
-- lvim.keys.normal_mode["<Enter>"] = "ciw"

lvim.builtin.which_key.mappings["L"]["t"] = { "<cmd>LvimToggleFormatOnSave<cr>", "Toggle Format on Save" }

lvim.builtin.which_key.vmappings["s"] = { [["sy:let @/=@s<CR>cgn]], "Search/Replace" }

-- BUG: This doesn't work as expected
lvim.builtin.which_key.vmappings["l"] = { name = "LSP", a = { vim.lsp.buf.code_action, "Code Action" } }

-- lvim.builtin.treesitter.incremental_selection = {
--   enable = true,
--   keymaps = { node_incremental = "<Tab>", init_selection = "<Tab>", node_decremental = "<BS>" },
-- }

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
-- require("user.plugins.inlayhints")
require("user.plugins.mason")
require("user.plugins.openingh")
require("user.plugins.persistence")
require("user.plugins.refactoring")
require("user.plugins.treesitter")
