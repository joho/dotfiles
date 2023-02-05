"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundle')
  call dein#begin('~/.vim/bundle')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundle/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('rking/ag.vim')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('scrooloose/syntastic')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('fatih/vim-go')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('pangloss/vim-javascript')
  call dein#add('mxw/vim-jsx')
  call dein#add('tpope/vim-markdown')
  call dein#add('prettier/vim-prettier')
  call dein#add('tpope/vim-surround')
  call dein#add('nikvdp/ejs-syntax')
  call dein#add('Quramy/tsuquyomi')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('merlinrebrovic/focus.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

set hidden

syntax on                               " duh
set autoindent smartindent cindent      " go for all indenting, all the time
set incsearch                           " do incremental searching
set hlsearch                            " highlight search results
set ts=2 sw=2 sts=2                     " default to 2 space tabs
set expandtab                           " always use spaces not tabs
autocmd BufWritePre * :%s/\s\+$//e      " delete trailing whitespace on save

" write swapfiles out to temp instead of polluting working directory
set directory=/tmp/

" Set up the status line
set laststatus=2        " Always show it.
let g:airline#extensions#syntastic#enabled = 1

" ignoring certain file types
set wildignore+=*.o,*.obj,.git,.DS_Store,*.swp,vendor/bundle/**,tmp/**,public/source_maps/**,node_modules/*

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

" Disable gui tabs because they lol shit up in macvim
set go-=e

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

" Ctrl-P
map <leader>t :CtrlPMixed<cr>

" CtrlP auto cache clearing.
" --------------------------
function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction
if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

"
" open routes or gemfile up top
au FileType ruby map <leader>gr :topleft :split config/routes.rb<cr>
au FileType ruby map <leader>gg :topleft 100 :split Gemfile<cr>

" end keymapping

" FILETYPE SHIT
" =============

" Enable file type detection
filetype plugin on
filetype indent on

" Indentation shame
let g:LookOfDisapprovalTabThreshold=5
let g:LookOfDisapprovalSpaceThreshold=(&tabstop*5)

" git stuff
au FileType gitconfig setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist
" stop git commit messages jumping to last location
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" custom hax to get ruby syntax highlighting in files that don't end in .rb
" Thanks: http://dailyvim.tumblr.com/post/1262764095/additional-ruby-syntax-highlighting
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" golang specific stuff
" ---
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist
" still save if fmt fails
let g:go_fmt_fail_silently = 1
" don't autoinstall things
let g:go_disable_autoinstall = 0
" use go imports!
let g:go_fmt_command = "goimports"
" extra syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" gd => go to defintion
au FileType go nmap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)

au FileType go nmap <Leader>gr :GoRename<CR>

let g:go_list_type = "quickfix"

" PHP ugh
autocmd FileType php setlocal expandtab ts=4 sw=4 sts=4

" javascript
let g:jsx_ext_required = 0
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql Prettier

" end filetype shit

autocmd FileType go setlocal omnifunc=go#complete#Complete
" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_javascript_checkers = ['eslint']
" ignore a bunch of irritating messages for html template files
let g:syntastic_html_tidy_quiet_messages = { "level" : "warnings" }

" for focus.vim
let g:focusmode_width = 72
