(local {: autoload} (require :nfnl.module))
(local nvim (autoload :nvim))

[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-telescope/telescope-ui-select.nvim
                 :nvim-lua/popup.nvim
                 :nvim-lua/plenary.nvim]
  :init (fn []
          (nvim.set_keymap :n :<leader>f
                           ":lua require('telescope.builtin').git_files()<CR>"
                           {:noremap true})
          (nvim.set_keymap :n :<leader>sf
                           ":lua require('telescope.builtin').find_files()<CR>"
                           {:noremap true})
          (nvim.set_keymap :n :<leader>st
                           ":lua require('telescope.builtin').live_grep()<CR>"
                           {:noremap true})
          (nvim.set_keymap :n :<leader><leader>
                           ":lua require('telescope.builtin').buffers()<CR>"
                           {:noremap true})
          (nvim.set_keymap :n :<leader>sh
                           ":lua require('telescope.builtin').help_tags()<CR>"
                           {:noremap true})
          (nvim.set_keymap :n :<leader>sr
                           ":lua require('telescope.builtin').resume()<CR>"
                           {:noremap true}))
  :config (fn []
            (let [telescope (require :telescope)
                  themes (require :telescope.themes)]
              (telescope.setup {:defaults {:mappings {:n {:q :close}}
                                           :file_ignore_patterns [:node_modules]
                                           :vimgrep_arguments [:rg
                                                               :--color=never
                                                               :--no-heading
                                                               :--with-filename
                                                               :--line-number
                                                               :--column
                                                               :--smart-case
                                                               :--iglob
                                                               :!.git
                                                               :--hidden]}
                                :extensions {:ui-select {1 (themes.get_dropdown {})}}
                                :pickers {:find_files {:find_command [:rg
                                                                      :--files
                                                                      :--iglob
                                                                      :!.git
                                                                      :--hidden]}
                                          :buffers {:mappings {:n {:dd :delete_buffer}}}}})
              (telescope.load_extension :ui-select)))}]
