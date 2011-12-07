
set mousehide                   " Hide the mouse when typing text.
set guioptions=egm              " Show tabs, hide toolbar and scrollbar.


set linespace=0                 " 0 pixels between lines

colorscheme railscasts

" Better colours for folding.
highlight Folded guifg=#EEEEEE guibg=#333333

if has("gui_macvim")
  set gfn=Inconsolata:h16         " Inconsolata 18px for the font
  set fuoptions=maxvert,maxhorz   " Go to full width and height in full screen mode.
end
