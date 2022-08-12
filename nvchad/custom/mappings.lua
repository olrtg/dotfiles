local M = {}

M.disabled = {
	n = {
		["<leader>f"] = "",
		["<leader>ff"] = "",
		["<leader>ca"] = "",
		["<leader>cm"] = "",
		["<leader>x"] = "",
		["<leader>w"] = "",
		["<leader>wa"] = "",
		["<leader>wk"] = "",
		["<leader>wK"] = "",
		["<leader>wl"] = "",
		["<leader>wr"] = "",
		["<C-n>"] = "",
	},
}

M.explorer = {
	n = {
		["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "  toggle explorer" },
	},
}

M.editor = {
	n = {
		["<C-a>"] = { "gg0vG$", "select all" },
		["<leader>w"] = { "<cmd>w<cr>", "  save file" },
		["<leader>q"] = { "<cmd>q<cr>", "  quit" },
		["<leader>/"] = { '<cmd>let @/=""<cr>', "  no highlight" },

		["<leader>c"] = {
			function()
				require("core.utils").close_buffer()
			end,
			"  close buffer",
		},

		["<S-l>"] = {
			function()
				require("core.utils").tabuflineNext()
			end,
			"goto next buffer",
		},

		["<S-h>"] = {
			function()
				require("core.utils").tabuflinePrev()
			end,
			"goto prev buffer",
		},
	},

	i = {
		["jk"] = { "<Esc>" },
	},
}

M.git = {
	n = {
		["<leader>g"] = { "", "git" },
		["<leader>gg"] = {
			function()
				require("nvterm.terminal").send("lazygit", "vertical")
			end,
			"lazygit",
		},
	},
}

M.search = {
	n = {
		["<leader>s"] = { "", "search" },
		["<leader>sf"] = { "<cmd>Telescope find_files<cr>", "  search files" },
		["<leader>st"] = { "<cmd>Telescope live_grep<cr>", "  search text" },
		["<leader>sh"] = { "<cmd>Telescope help_tags<cr>", "  search docs" },
		["<leader>sk"] = { "<cmd>Telescope keymaps<cr>", "  search keymaps" },
	},
}

M.lsp = {
	n = {
		["<leader>l"] = { "", "lsp" },
		["<leader>la"] = { "<cmd>Lspsaga code_action<cr>", "  code action" },
		["<leader>lr"] = { "<cmd>Lspsaga rename<cr>", "凜 rename" },
		["S-k"] = { "<cmd>Lspsaga hover_doc<cr>" },
		["gl"] = { "<cmd>Lspsaga show_line_diagnostics<cr>" },
	},

	v = {
		["<leader>la"] = { "<cmd><C-U>Lspsaga range_code_action<cr>", "  code action" },
	},
}

return M
