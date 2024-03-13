local api = require("user.utils.api")

api.override_servers({ "jdtls" })

api.install_tools({ "jdtls", "java-debug-adapter", "java-test" })

api.install_plugins({
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },
})

api.install_parsers({ "java" })

require("lvim.lsp.manager").setup("jdtls", {
  settings = {
    java = {
      configuration = {
        runtimes = {
          { name = "JavaSE-20", path = "~/.asdf/installs/java/adoptopenjdk-20.0.2+9" },
          { name = "JavaSE-11", path = "~/.asdf/installs/java/adoptopenjdk-11.0.20+8" },
          { name = "JavaSE-1.8", path = "~/.asdf/installs/java/zulu-8.72.0.17" },
        },
      },
      format = {
        settings = {
          url = "~/eclipse-java-stoplight-style.xml",
          profile = "StoplightStyle",
        },
      },
    },
  },
})
