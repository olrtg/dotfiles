local M = {}

M.typescript_setup = function()
  -- https://github.com/jose-elias-alvarez/typescript.nvim#setup
  -- https://github.com/ChristianChiarulli/lvim/blob/master/lua/user/lsp/languages/js-ts.lua
  require("typescript").setup({
    debug = false,
    go_to_source_definition = {
      fallback = true,
    },
    server = {
      on_attach = require("lvim.lsp").common_on_attach,
      on_init = require("lvim.lsp").common_on_init,
      capabilities = require("lvim.lsp").common_capabilities(),
    },
  })

  local ok, null_ls = pcall(require, "null-ls")

  if not ok then
    return
  end

  local code_actions = require("typescript.extensions.null-ls.code-actions")
  null_ls.register(code_actions)
end

M.mason_installer_setup = function()
  require("mason-tool-installer").setup({
    ensure_installed = {
      "astro-language-server",
      "bash-language-server",
      "black",
      "css-lsp",
      "dockerfile-language-server",
      "editorconfig-checker",
      "emmet-ls",
      "eslint-lsp",
      "eslint_d",
      "flake8",
      "hadolint",
      "html-lsp",
      "json-lsp",
      "jsonlint",
      "lua-language-server",
      "markdownlint",
      "prettierd",
      "prisma-language-server",
      "proselint",
      "pyright",
      "shellcheck",
      "shfmt",
      "stylelint-lsp",
      "stylua",
      "tailwindcss-language-server",
      "taplo",
      "typescript-language-server",
      "vim-language-server",
      "yaml-language-server",
    },
  })
end

M.flutter_tools_setup = function()
  require("flutter-tools").setup({
    fvm = true,
    flutter_path = os.getenv("HOME") .. "/fvm/default/bin/flutter",
    lsp = {
      capabilities = require("lvim.lsp").common_capabilities,
      on_attach = require("lvim.lsp").common_on_attach,
      color = { enabled = true },
    },
    -- debugger = {
    --   enabled = true,
    --   run_via_dap = true,
    --   -- don't pause on exception in flutter
    --   exception_breakpoints = {},
    --   register_configurations = function(paths)
    --     require("dap").configurations.dart = {
    --       {
    --         name = "Launch App",
    --         request = "launch",
    --         type = "dart",
    --         dartSdkPath = paths.dart_sdk,
    --         flutterSdkPath = paths.flutter_sdk,
    --       },
    --       {
    --         name = "Launch App (profile mode)",
    --         request = "launch",
    --         type = "dart",
    --         flutterMode = "profile",
    --         dartSdkPath = paths.dart_sdk,
    --         flutterSdkPath = paths.flutter_sdk,
    --       },
    --       {
    --         name = "Launch App (release mode)",
    --         request = "launch",
    --         type = "dart",
    --         flutterMode = "release",
    --         dartSdkPath = paths.dart_sdk,
    --         flutterSdkPath = paths.flutter_sdk,
    --       },
    --     }
    --   end,
    -- },
    widget_guides = { enabled = true },
  })
end

M.lsp_signature_setup = function()
  -- https://github.com/ray-x/lsp_signature.nvim
  -- https://github.com/abzcoding/lvim/blob/main/lua/user/lsp_signature.lua
  require("lsp_signature").setup({
    bind = true,
    doc_lines = 10,
    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
    floating_window_above_cur_line = true,
    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "Search", -- how your parameter will be highlight
    max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, single, shadow, none
    },
    zindex = 1002, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    debug = false, -- set to true to enable debug logging
    log_path = "debug_log_file_path", -- debug log path
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  })
end

return M
