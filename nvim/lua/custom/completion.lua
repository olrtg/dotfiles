local lsp_zero = require("lsp-zero")

local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()

-- this is the function that loads the extra snippets
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- confirm completion item
		["<C-y>"] = cmp.mapping.confirm({ select = true }),

		-- trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),

		-- scroll up and down the documentation window
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		-- navigate between snippet placeholders
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
	}),
	-- note: if you are going to use lsp-kind (another plugin)
	-- replace the line below with the function from lsp-kind
	formatting = lsp_zero.cmp_format({ details = true }),
})
