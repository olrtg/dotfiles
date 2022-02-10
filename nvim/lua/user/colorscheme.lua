vim.cmd [[
try
  let g:gruvbox_material_transparent_background = 1
  colorscheme gruvbox-material
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
