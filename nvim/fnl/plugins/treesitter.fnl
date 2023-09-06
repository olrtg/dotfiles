[{1 :nvim-treesitter/nvim-treesitter
  :build ":TSUpdate"
  :config (fn []
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup {:highlight {:enable true}
                                 :indent {:enable true}
                                 :ensure_installed [:bash
                                                    :clojure
                                                    :query
                                                    :dockerfile
                                                    :fennel
                                                    :html
                                                    :java
                                                    :javascript
                                                    :typescript
                                                    :tsx
                                                    :json
                                                    :python
                                                    :lua
                                                    :markdown
                                                    :yaml]})))}]