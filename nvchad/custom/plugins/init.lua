return {
	-- menu for mappings
	["folke/which-key.nvim"] = { disable = false },

	-- format & linting
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},

	-- lsp setup
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},

	["glepnir/lspsaga.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("lspsaga").init_lsp_saga({ max_preview_lines = 50 })
		end,
	},

	-- dim inactive windows
	["andreadev-it/shade.nvim"] = {
		module = "shade",
		config = function()
			require("custom.plugins.smallconfigs").shade()
		end,
	},
}
