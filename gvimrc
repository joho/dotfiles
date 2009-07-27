" http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim
filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.

set ruler  " Ruler on
set nu  " Line numbers on
set nowrap  " Line wrapping off
set number " line numbers
set hlsearch
syntax on


" tabby-mctabs
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set backspace=start,indent


" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes