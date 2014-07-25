
set mousehide                   " Hide the mouse when typing text.
set guioptions=egm              " Show tabs, hide toolbar and scrollbar.


set linespace=0                 " 0 pixels between lines

colorscheme jellybeans_pda

" Better colours for folding.
highlight Folded guifg=#EEEEEE guibg=#333333

if has("gui_macvim")
  set guifont=Meslo\ LG\ S\ DZ:h15  " :set gfn=*, then :set gfn?
  set fuoptions=maxvert,maxhorz     " Go to full width and height in full screen mode.

  " unbind command-T from new tab and rebind to :CommandT
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>

end
