local api = require("user.utils.api")

api.install_plugins({
  { "nvim-treesitter/nvim-treesitter-textobjects", before = "nvim-treesitter" },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
    config = function()
      lvim.builtin.which_key.mappings["T"]["p"] = { "<cmd>TSPlaygroundToggle<cr>", "Playground" }
    end,
  },
})

api.install_parsers({
  "c",
  "cpp",
  "java",
  "query", -- for .scheme files (used by treesitter highlighter)
  "ruby",
})

--
-- nvim-treesitter-textobjects
--
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
