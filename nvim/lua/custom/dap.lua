local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup()

dapui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

do
	vim.keymap.set("n", "<leader>dt", function() dap.toggle_breakpoint() end)
	vim.keymap.set("n", "<leader>dc", function() dap.continue() end)
	vim.keymap.set("n", "<leader>dC", function() dap.run_to_cursor() end)
	vim.keymap.set("n", "<leader>di", function() dap.step_into() end)
	vim.keymap.set("n", "<leader>do", function() dap.step_over() end)
	vim.keymap.set("n", "<leader>du", function() dap.step_out() end)
	vim.keymap.set("n", "<leader>db", function() dap.step_back() end)
	vim.keymap.set("n", "<leader>dr", function() dap.restart() end)
end

do -- NOTE: open and close dapui automatically
	dap.listeners.before.attach.dapui_config = function() dapui.open() end
	dap.listeners.before.launch.dapui_config = function() dapui.open() end

	dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
	dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
end
