[{
  1 :zbirenbaum/copilot.lua
  :config (fn []
            (local copilot (require :copilot))
            (copilot.setup {:suggestion {:auto_trigger true
                                         :keymap {:accept :<M-Enter>
                                                  :accept_line :<M-l>
                                                  :accept_word :<M-w>
                                                  :dismiss :<M-c>
                                                  :next "<M-]>"
                                                  :prev "<M-[>"}}}))}]


