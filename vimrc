" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set hidden

" Load pathogen for managing all those pesky plugins.
" Load this first so ftdetect in bundles works properly.
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

syntax on                               " duh
set autoindent smartindent cindent  " go for all indenting, all the time
set ts=2 sw=2 sts=2     " default to 2 space tabs
set expandtab           " always use spaces not tabs
set incsearch           " do incremental searching
set hlsearch            " highlight search results

" write swapfiles out to temp instead of polluting working directory
set directory=/tmp/

" Set up the status line
set laststatus=2        " Always show it.
set statusline=%([%M%R%H%W]\ \ %)Line:\ %l/%L\ %{fugitive#statusline()}\ \ %f%=%{&filetype}\ \ Column:\ %c

" ignoring certain file types
set wildignore+=*.o,*.obj,.git,.DS_Store,*.swp

" automatically create parent dirs on write buffer - http://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
augroup BWCCreateDir
  au!
  autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
augroup END


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

" ------
" DAS window sizing suggestion
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=7
set winminheight=7
set winheight=999
" ------

" Keymapping shit
" =========

" i want an easier to use leader!
let mapleader = ","

" Reselect the visual area when changing indenting in visual mode.
vnoremap < <gv
vnoremap > >gv

" a shortcut for command-t
nmap :gt<CR> :CommandT<CR>

" sick of holding shift to do everything!
nnoremap ; :

" shortcut for switch to last file
map <leader><leader> <C-^>

" easy way to clear highlighted searches
nmap <silent> <leader>/ :nohlsearch<CR>

" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" end keymapping

" FILETYPE SHIT
" =============

" Enable file type detection
filetype plugin on
filetype indent on

" end filetype shit
