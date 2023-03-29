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
      "rustywind",
      "shellcheck",
      "shfmt",
      "stylelint-lsp",
      "stylua",
      "tailwindcss-language-server",
      "taplo",
      "typescript-language-server",
      "vim-language-server",
      "vue-language-server",
      "yaml-language-server",
    },
  })
end

M.flutter_tools_setup = function()
  require("flutter-tools").setup({
    fvm = true,
    flutter_path = os.getenv("HOME") .. "/fvm/default/bin/flutter",
    lsp = {
      on_attach = require("lvim.lsp").common_on_attach,
      color = { enabled = true },
    },
    widget_guides = { enabled = true },
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
end

M.copilot_setup = function()
  vim.defer_fn(function()
    require("copilot").setup({
      plugin_manager_path = os.getenv("LUNARVIM_RUNTIME_DIR") .. "/site/pack/packer",
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<M-Enter>",
          accept_line = "<M-l>",
          accept_word = "<M-w>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<M-c>",
        },
      },
    })
  end, 800)
end

return M
