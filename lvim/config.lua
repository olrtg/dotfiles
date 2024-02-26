--
-- LunarVim
--
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 5000

lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.alpha.active = false
lvim.builtin.bufferline.active = false
lvim.builtin.nvimtree.active = false

lvim.builtin.treesitter.context_commentstring = nil -- https://github.com/LunarVim/LunarVim/issues/4468
lvim.builtin.treesitter.autotag.enable = true

lvim.lazy.opts.dev = { path = "~/i" }
lvim.colorscheme = "onedark"

vim.o.spell = true
vim.o.spellfile = get_config_dir() .. "/spell/en.utf-8.add"

--
-- Plugins
--
lvim.plugins = {
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" },
  { "tpope/vim-surround" },
  { "tjdevries/cyclist.vim" },
  { "folke/lsp-colors.nvim" },
  { "folke/tokyonight.nvim" },
  { "farmergreg/vim-lastplace" },
  { "j-hui/fidget.nvim", opts = {} },
  { "inkarkat/vim-AdvancedSorters", dependencies = "inkarkat/vim-ingo-library" },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

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
    keys = { { "<leader>S", require("persistence").load } },
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
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
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

  {
    "almo7aya/openingh.nvim",
    config = true,
    init = function()
      lvim.builtin.which_key.mappings["g"]["r"] = { "<cmd>OpenInGHRepo<cr>", "Open Repo (GH)" }
      lvim.builtin.which_key.mappings["g"]["f"] = { "<cmd>OpenInGHFile<cr>", "Open File (GH)" }
    end,
  },

  {
    "ThePrimeagen/git-worktree.nvim",
    config = true,
    init = function()
      require("telescope").load_extension("git_worktree")
      lvim.builtin.which_key.mappings["g"]["w"] =
        { require("telescope").extensions.git_worktree.git_worktrees, "Worktrees" }
      lvim.builtin.which_key.mappings["g"]["W"] =
        { require("telescope").extensions.git_worktree.create_git_worktree, "Create worktree" }
    end,
  },

  -- My own plugins
  {
    "olrtg/nvim-i18n",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = true,
    dev = true,
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

--
-- Custom stuff
--
vim.api.nvim_create_user_command("CopyJsonPath", require("user.custom.copy-json-path").exec, {})

--
-- Modules
--
require("user.autocommands")

require("user.languages.docker")
require("user.languages.lisp")
require("user.languages.flutter")
require("user.languages.golang")
require("user.languages.java")
require("user.languages.lua")
require("user.languages.markdown")
-- require("user.languages.ocaml")
require("user.languages.python")
require("user.languages.serialized")
require("user.languages.shell")
require("user.languages.web")

require("user.tooling.prettier")

require("user.plugins.colorizer")
-- require("user.plugins.copilot")
require("user.plugins.flash")
require("user.plugins.mason")
require("user.plugins.treesitter")
