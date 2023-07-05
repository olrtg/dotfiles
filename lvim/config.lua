--
-- LunarVim
--
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 5000
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.alpha.active = false
-- lvim.colorscheme = "tokyonight"

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#center-a-floating-nvim-tree-window
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.4

lvim.builtin.nvimtree.setup.view = {
  float = {
    enable = true,
    open_win_config = function()
      local screen_w = vim.opt.columns:get()
      local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
      local window_w = screen_w * WIDTH_RATIO
      local window_h = screen_h * HEIGHT_RATIO
      local window_w_int = math.floor(window_w)
      local window_h_int = math.floor(window_h)
      local center_x = (screen_w - window_w) / 2
      local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

      return {
        border = "rounded",
        relative = "editor",
        row = center_y,
        col = center_x,
        width = window_w_int,
        height = window_h_int,
      }
    end,
  },
  width = function()
    return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
  end,
}

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
  { "axelvc/template-string.nvim", config = true },
  { "simrat39/symbols-outline.nvim", config = true },
  { "j-hui/fidget.nvim", version = "legacy", config = true },
  { "folke/todo-comments.nvim", event = "BufRead", config = true },
  { "inkarkat/vim-AdvancedSorters", dependencies = "inkarkat/vim-ingo-library" },
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
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
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

lvim.builtin.which_key.mappings["L"]["t"] = { "<cmd>LvimToggleFormatOnSave<cr>", "Toggle Format on Save" }
lvim.builtin.which_key.mappings["T"]["p"] = { "<cmd>TSPlaygroundToggle<cr>", "Playground" }

lvim.builtin.which_key.vmappings["s"] = { [["sy:let @/=@s<cr>cgn]], "Search/Replace" }

-- BUG: this doesn't work as expected
-- lvim.builtin.which_key.vmappings["l"] = { name = "lsp", a = { vim.lsp.buf.code_action, "Code Action" } }

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
-- require("user.plugins.flash")
-- require("user.plugins.inlayhints")
require("user.plugins.mason")
require("user.plugins.openingh")
require("user.plugins.persistence")
require("user.plugins.refactoring")
require("user.plugins.treesitter")
