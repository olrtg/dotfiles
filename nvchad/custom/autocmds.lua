local M = {}
local autocmd = vim.api.nvim_create_autocmd

M.format_on_save = function(bufnr)
	autocmd({ "BufWritePre" }, {
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.formatting_seq_sync({}, 300)
		end,
	})
end

return M
