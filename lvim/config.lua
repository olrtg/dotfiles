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
lvim.lazy.opts.dev = { path = "~/i" }

vim.o.relativenumber = true

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
  { "j-hui/fidget.nvim", opts = {} },
  { "inkarkat/vim-AdvancedSorters", dependencies = "inkarkat/vim-ingo-library" },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },

  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("sg").setup({ enable_cody = true, accept_tos = true })
      table.insert(lvim.builtin.cmp.sources, { name = "cody" })
      lvim.builtin.cmp.formatting.source_names.cody = "(Cody)"
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
    config = function()
      require("neo-tree").setup({
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
      })
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

  {
    "almo7aya/openingh.nvim",
    config = function()
      require("openingh").setup()
      lvim.builtin.which_key.mappings["g"]["r"] = { "<cmd>OpenInGHRepo<cr>", "Open Repo (GH)" }
      lvim.builtin.which_key.mappings["g"]["f"] = { "<cmd>OpenInGHFile<cr>", "Open File (GH)" }
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
require("user.plugins.persistence")
require("user.plugins.treesitter")
