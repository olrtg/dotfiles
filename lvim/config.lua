--
-- LunarVim
--
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 2000

lvim.builtin.alpha.active = false
lvim.builtin.bufferline.active = false
lvim.builtin.nvimtree.active = false
lvim.builtin.indentlines.active = false

lvim.builtin.treesitter.context_commentstring = nil -- https://github.com/LunarVim/LunarVim/issues/4468
lvim.builtin.treesitter.autotag.enable = true

lvim.lazy.opts.dev = { path = "~/i" }
lvim.colorscheme = "onedark"

vim.opt.list = true
vim.opt.listchars = { eol = "↵", nbsp = "◇", tab = "→ ", trail = "⋅" }

--
-- Plugins
--
lvim.plugins = {
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" },
  { "tpope/vim-surround" },
  { "folke/lsp-colors.nvim" },
  { "folke/tokyonight.nvim" },
  { "farmergreg/vim-lastplace" },
  { "stevearc/dressing.nvim", opts = {} },
  { "inkarkat/vim-AdvancedSorters", dependencies = "inkarkat/vim-ingo-library" },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  },

  {
    -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = false,
    config = true,
    init = function()
      require("onedark").load()
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = true,
    init = function()
      lvim.builtin.which_key.mappings["S"] = { require("persistence").load, "Restore session" }
    end,
  },

  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      popup_border_style = "rounded",
      window = {
        position = "float",
        mappings = { ["<leader>e"] = "cancel" },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
    init = function()
      lvim.builtin.which_key.mappings["e"] = { "<cmd>Neotree reveal<cr>", "Explorer" }
    end,
  },

  {
    "benfowler/telescope-luasnip.nvim",
    after = "telescope.nvim",
    keys = { "<leader>ss" },
    init = function()
      require("telescope").load_extension("luasnip")
      lvim.builtin.which_key.mappings["ss"] = { "<cmd>Telescope luasnip<cr>", "Snippets" }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { "<leader>mm", "<leader>ma", "<leader>ms", "<leader>md", "<leader>mf", "<leader><leader>" },
    init = function()
      local harpoon = require("harpoon")
      -- stylua: ignore start
      lvim.builtin.which_key.mappings["m"] = {
        name = "Harpoon",
        m = { function() harpoon:list():append() end, "Mark File" },
        a = { function() harpoon:list():select(1) end, "Go to Mark 1" },
        s = { function() harpoon:list():select(2) end, "Go to Mark 2" },
        d = { function() harpoon:list():select(3) end, "Go to Mark 3" },
        f = { function() harpoon:list():select(4) end, "Go to Mark 4" },
      }
      lvim.builtin.which_key.mappings["<leader>"] = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        "Marks Menu", }
      -- stylua: ignore end
    end,
  },

  -- NOTE: now nvim-dap requires this
  { "nvim-neotest/nvim-nio" },

  -- My own plugins
  {
    "olrtg/nvim-i18n",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = true,
    dev = true,
  },

  -- {
  --   "olrtg/react-cult",
  --   main = "packages/neovim",
  --   config = true,
  --   dev = true,
  -- },
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

lvim.keys.normal_mode["<C-a>"] = "ggVGy" -- select everything in a buffer

lvim.builtin.which_key.mappings["L"]["t"] = { "<cmd>LvimToggleFormatOnSave<cr>", "Toggle Format on Save" }
lvim.builtin.which_key.mappings["T"]["p"] = { "<cmd>InspectTree<cr>", "Playground" }

lvim.builtin.which_key.mappings["l"]["h"] = {
  function()
    local bufnr = 0
    if vim.lsp.inlay_hint.is_enabled(bufnr) then
      vim.lsp.inlay_hint.enable(bufnr, false)
      return
    end

    vim.lsp.inlay_hint.enable(bufnr, true)
  end,
  "Toggle Inlay Hints",
}

lvim.builtin.which_key.vmappings["s"] = { [["sy:let @/=@s<cr>cgn]], "Search/Replace" }
lvim.builtin.which_key.vmappings["l"] = { name = "lsp", a = { vim.lsp.buf.code_action, "Code Action" } }

lvim.builtin.telescope.defaults.mappings.n["q"] = require("telescope.actions").close
lvim.builtin.telescope.pickers.help_tags = {
  mappings = {
    i = { ["<cr>"] = require("telescope.actions").select_vertical },
    n = { ["<cr>"] = require("telescope.actions").select_vertical },
  },
}

--
-- Custom stuff
--
vim.api.nvim_create_user_command("CopyJsonPath", require("user.custom.copy-json-path").exec, {})

--
-- Modules
--
require("user.autocommands")

require("user.utils.api").override_servers({ "dprint", "snyk_ls" })

require("user.languages.docker")
require("user.languages.flutter")
require("user.languages.golang")
require("user.languages.java")
-- require("user.languages.lisp")
require("user.languages.lua")
require("user.languages.markdown")
-- require("user.languages.ocaml")
-- require("user.languages.python")
require("user.languages.rust")
require("user.languages.serialized")
require("user.languages.shell")
require("user.languages.web")
require("user.tooling.prettier")

require("user.plugins.colorizer")
require("user.plugins.copilot")
require("user.plugins.flash")
require("user.plugins.mason")
require("user.plugins.treesitter")
