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
end

M.mason_installer_setup = function()
  require("mason-tool-installer").setup({
    ensure_installed = {
      "astro-language-server",
      "bash-language-server",
      "css-lsp",
      "dockerfile-language-server",
      "editorconfig-checker",
      "emmet-ls",
      "eslint-lsp",
      "eslint_d",
      "hadolint",
      "html-lsp",
      "json-lsp",
      "jsonlint",
      "lua-language-server",
      "markdownlint",
      "prettierd",
      "prisma-language-server",
      "proselint",
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

return M
