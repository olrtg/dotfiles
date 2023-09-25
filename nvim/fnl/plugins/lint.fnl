[{1 :mfussenegger/nvim-lint
  :config (fn []
            (local lint (require :lint))
            (set lint.linters_by_ft
                 {:javascript [:eslint_d]
                  :typescript [:eslint_d]
                  :typescriptreact [:eslint_d]
                  :javascriptreact [:eslint_d]}))}]
