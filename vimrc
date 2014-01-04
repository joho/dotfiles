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
set incsearch           " do incremental searching
set hlsearch            " highlight search results
set ts=2 sw=2 sts=2     " default to 2 space tabs
set expandtab           " always use spaces not tabs
autocmd BufWritePre * :%s/\s\+$//e      " delete trailing whitespace on save

" write swapfiles out to temp instead of polluting working directory
set directory=/tmp/

" Set up the status line
set laststatus=2        " Always show it.
set statusline=%([%M%R%H%W]\ \ %)Line:\ %l/%L\ %{fugitive#statusline()}\ \ %f%=%{&filetype}\ \ Column:\ %c

" ignoring certain file types
set wildignore+=*.o,*.obj,.git,.DS_Store,*.swp,vendor/bundle/**,tmp/**,public/source_maps/**

" automatically create parent dirs on write buffer - http://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
augroup BWCCreateDir
  au!
  autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
augroup END

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

" sick of holding shift to do everything!
cnoremap ; :

" shortcut for switch to last file
map <leader><leader> <C-^>

" easy way to clear highlighted searches
nmap <silent> <leader>/ :nohlsearch<CR>

" bog standard command t
map <leader>t :CommandT<cr>

" open routes or gemfile up top
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gd :topleft 100 :split db/schema.rb<cr>

" bunch of rails specific command t thingos
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>

" set up commandT to auto flush the buffer when a new file is written
" borrowed from http://stackoverflow.com/questions/3486747/run-the-commandtflush-command-when-a-new-file-is-written
augroup NFUCT
    autocmd!
    autocmd BufWritePre * call NFUCTset()
augroup END
function NFUCTset()
    if !filereadable(expand('%'))
        augroup NFUCT
            autocmd BufWritePost * call NFUCT()
        augroup END
    endif
endfunction
function NFUCT()
    augroup NFUCT
        autocmd!
        autocmd BufWritePre * call NFUCTset()
    augroup END
    CommandTFlush
endfunction
" end command T magic

nnoremap <leader>aa :Ag<space>

cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" pete's run rspec in iterm thingo
" https://github.com/notahat/dotfiles/blob/master/vim/plugin/iterm.vim
map <D-r> :Spec<CR>

" end keymapping

" FILETYPE SHIT
" =============

" Enable file type detection
filetype plugin on
filetype indent on

" custom hax to get ruby syntax highlighting in files that don't end in .rb
" Thanks: http://dailyvim.tumblr.com/post/1262764095/additional-ruby-syntax-highlighting
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" golang specific stuff

" autorun Fmt before save
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" tabs not spaces for go
autocmd FileType go setlocal noexpandtab ts=4 tw=0

" PHP ugh
autocmd FileType php setlocal expandtab ts=4 sw=4 sts=4

" end filetype shit
