set mousehide                   " Hide the mouse when typing text.
set guioptions=eg              " Show tabs, hide toolbar and scrollbar.

set linespace=0                 " 0 pixels between lines

colorscheme jellybeans_pda

" Better colours for folding.
highlight Folded guifg=#EEEEEE guibg=#333333

" use the fancy powerline symbols
let g:airline_powerline_fonts = 1


if has("gui_macvim")
  set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline:h15  " :set gfn=*, then :set gfn?
  set fuoptions=maxvert,maxhorz     " Go to full width and height in full screen mode.
else
  " Linux settings
  set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline\ 13 " :set gfn=*, then :set gfn?
  map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
end
