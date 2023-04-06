local api = require("user.utils.api")

api.override_servers({ "dartls" })

api.install_plugins({
  {
    "akinsho/flutter-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
})

api.install_parsers({ "dart" })

--
-- flutter-tools.nvim
--
api.setup_plugin("flutter-tools", {
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

require("telescope").load_extension("flutter")

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