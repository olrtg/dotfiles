local lint = require("lint")
local sqlfluff = lint.linters.sqlfluff

sqlfluff.args = {
	"lint",
	"--format=json",
	"--dialect=postgres",
}

lint.linters_by_ft = {
	sql = { "sqlfluff" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function() lint.try_lint() end,
})
