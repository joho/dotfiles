" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Load pathogen for managing all those pesky plugins.
" Load this first so ftdetect in bundles works properly.
call pathogen#runtime_append_all_bundles()

syntax on                               " duh
set autoindent nosmartindent nocindent  " go for simple autoindenting
set ts=2 sw=2 sts=2     " default to 2 space tabs
set expandtab           " always use spaces not tabs
set incsearch           " do incremental searching
set hlsearch            " highlight search results

" Set up the status line
set laststatus=2        " Always show it.
set statusline=%([%M%R%H%W]\ \ %)Line:\ %l/%L\ %{fugitive#statusline()}\ \ %f%=%{&filetype}\ \ Column:\ %c

" macvim shit
if has("gui_macvim")
  set mousehide                   " Hide the mouse when typing text.
  set guioptions=egm              " Show tabs, hide toolbar and scrollbar.
  set fuoptions=maxvert,maxhorz   " Go to full width and height in full screen mode.

  set gfn=Inconsolata:h16         " Inconsolata 18px for the font
  set linespace=0                 " 0 pixels between lines

  colorscheme railscasts

  " Better colours for folding.
  highlight Folded guifg=#EEEEEE guibg=#333333

endif

" Keymapping shit
" =========

" Reselect the visual area when changing indenting in visual mode.
vnoremap < <gv
vnoremap > >gv

" end keymapping

" FILETYPE SHIT
" =============

" Enable file type detection, but disable smart indenting.
filetype plugin on
filetype indent off

" end filetype shit
