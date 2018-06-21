" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set hidden

" Load pathogen for managing all those pesky plugins.
" Load this first so ftdetect in bundles works properly.
execute pathogen#infect()

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

" https://github.com/wincent/command-t
map <leader>t :CommandT<cr>

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

let g:CommandTFileScanner='watchman'
" below command doesn't work with watchman (need to set config elsewhere, see https://facebook.github.io/watchman/docs/config.html)
"let g:CommandTWildIgnore=&wildignore . ",**/node_modules/*,**/Godeps/_workspace/*,**/app/cache/*,**/log/*,**/bower_components/*"
" end command T magic

if executable('rg')
  nnoremap <leader>aa :Rg<space>
else
  nnoremap <leader>aa :Ag<space>
endif

" pete's run rspec in iterm thingo
" https://github.com/notahat/dotfiles/blob/master/vim/plugin/iterm.vim
au FileType ruby map <D-r> :Spec<CR>
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

" Code completion
" let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

autocmd FileType go setlocal omnifunc=go#complete#Complete
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" let g:neocomplete#sources#omni#input_patterns.go = '\h\w*|\h\w\.\w*'
let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
