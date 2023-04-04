--
-- Override server
--
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "dartls" })

--
-- Plugins
--
vim.list_extend(lvim.plugins, {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
})

--
-- Treesitter
--
vim.list_extend(lvim.builtin.treesitter.ensure_installed, { "dart" })

--
-- flutter-tools.nvim
--
local ok, flutter = pcall(require, "flutter-tools")

if not ok then
  vim.notify("flutter-tools.nvim not found!", vim.log.levels.WARN)
  return
end

flutter.setup({
  fvm = true,
  flutter_path = os.getenv("HOME") .. "/fvm/default/bin/flutter",
  lsp = {
    on_attach = require("lvim.lsp").common_on_attach,
    color = { enabled = true },
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
    -- if empty, dap will not stop on any exceptions, otherwise it will stop on those specified
    -- see |:help dap.set_exception_breakpoints()| for more info
    exception_breakpoints = {},
    register_configurations = function(_)
      require("dap").configurations.dart = {}
      require("dap.ext.vscode").load_launchjs()
    end,
  },
  dev_log = { enabled = false },
})

--
-- Telescope
--
require("telescope").load_extension("flutter")

--
-- Keybindings
--
lvim.builtin.which_key.mappings["F"] = {
  name = "Flutter",
  c = { "<cmd>FlutterCopyProfilerUrl<cr>", "Copy Profiler Url" },
  d = { "<cmd>FlutterDevices<cr>", "Devices" },
  D = { "<cmd>FlutterDevTools<cr>", "Dev Tools" },
  e = { "<cmd>FlutterEmulators<cr>", "Emulators" },
  h = { "<cmd>FlutterReload<cr>", "Reload" },
  H = { "<cmd>FlutterRestart<cr>", "Restart" },
  l = { "<cmd>FlutterLogClear<cr>", "Log Clear" },
  o = { "<cmd>FlutterOutlineToggle<cr>", "Outline" },
  p = { "<cmd>FlutterPubGet<cr>", "Pub Get" },
  q = { "<cmd>FlutterQuit<cr>", "Quit" },
  r = { "<cmd>FlutterRun<cr>", "Run" },
  v = { "<cmd>FlutterVisualDebug<cr>", "Visual Debug" },
}
