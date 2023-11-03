--
-- LunarVim
--
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 5000
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.alpha.active = false
lvim.builtin.bufferline.active = false

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

vim.o.relativenumber = true
vim.o.cmdheight = 0

--
-- Plugins
--
lvim.plugins = {
  { "imsnif/kdl.vim" },
  { "tpope/vim-repeat" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-abolish" },
  { "tpope/vim-surround" },
  { "tjdevries/cyclist.vim" },
  { "folke/lsp-colors.nvim" },
  { "folke/tokyonight.nvim" },
  { "dmmulroy/tsc.nvim", config = true },
  { "filNaj/tree-setter", enabled = false },
  { "axelvc/template-string.nvim", config = true },
  { "simrat39/symbols-outline.nvim", config = true },
  { "inkarkat/vim-AdvancedSorters", dependencies = "inkarkat/vim-ingo-library" },
  { "chrishrb/gx.nvim", event = { "BufEnter" }, dependencies = { "nvim-lua/plenary.nvim" }, config = true },

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
    "ThePrimeagen/harpoon",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("harpoon").setup()
      lvim.builtin.which_key.mappings["m"] = {
        name = "Harpoon",
        m = { require("harpoon.mark").add_file, "Mark File" },
        a = { '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', "Go to Mark 1" },
        s = { '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', "Go to Mark 2" },
        d = { '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', "Go to Mark 3" },
        f = { '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', "Go to Mark 4" },
      }
      lvim.builtin.which_key.mappings["<leader>"] = { require("harpoon.ui").toggle_quick_menu, "Marks Menu" }
    end,
  },

  -- NOTE: My plugins in development
  {
    dir = "~/i/nvim-i18n",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = true,
    enabled = true,
  },
}

--
-- Keybindings
--
vim.keymap.set("i", "jk", "<ESC>", { silent = true })
vim.keymap.set({ "i", "s" }, "<C-l>", function()
  local ls = require("luasnip")
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

lvim.keys.normal_mode["<C-a>"] = "ggVG" -- select everything in a buffer

lvim.builtin.which_key.mappings["L"]["t"] = { "<cmd>LvimToggleFormatOnSave<cr>", "Toggle Format on Save" }
lvim.builtin.which_key.mappings["T"]["p"] = { "<cmd>TSPlaygroundToggle<cr>", "Playground" }

lvim.builtin.which_key.mappings["l"]["h"] = {
  function()
    vim.lsp.inlay_hint(0, nil)
  end,
  "Toggle Inlay Hints",
}

lvim.builtin.which_key.vmappings["s"] = { [["sy:let @/=@s<cr>cgn]], "Search/Replace" }

lvim.builtin.which_key.vmappings["l"] = { name = "lsp", a = { vim.lsp.buf.code_action, "Code Action" } }

lvim.builtin.telescope.defaults.mappings.n["q"] = require("telescope.actions").close

lvim.builtin.nvimtree.setup.on_attach = function(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  -- custom mappings
  vim.keymap.set("n", "<Esc>", api.tree.close, opts("Close"))
end

--
-- Modules
--
require("user.autocommands")

require("user.languages.docker")
require("user.languages.lisp")
require("user.languages.flutter")
require("user.languages.java")
require("user.languages.lua")
require("user.languages.markdown")
require("user.languages.python")
require("user.languages.serialized")
require("user.languages.shell")
require("user.languages.web")

require("user.tooling.prettier")

require("user.plugins.colorizer")
-- require("user.plugins.copilot")
require("user.plugins.flash")
require("user.plugins.mason")
require("user.plugins.openingh")
require("user.plugins.persistence")
-- require("user.plugins.refactoring")
require("user.plugins.treesitter")
