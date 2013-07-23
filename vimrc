" Vanilla configs
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

filetype on
filetype plugin on
filetype indent on

if &t_Co > 2 || has('gui_running')
	syntax on
	set hlsearch
endif

set updatetime=10000
set updatecount=400

set nu

set shiftwidth=4
set tabstop=4
set smartindent

set smartcase

set encoding=utf-8

command Clear :let @/ = ""

" Plugin configs

" Pathogen config
execute pathogen#infect()

" Minibufexpl config
nmap <F2> :TMiniBufExplorer<CR>
nmap <F3> :MBEbp<CR>
nmap <F4> :MBEbn<CR>
map <Leader>mbf :MiniBufExplorer<CR>

" Powerline config
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2
set t_Co=256

" Tagbar config
nmap <F5> :TagbarToggle<CR>

" Syntastic config
let g:syntastic_check_on_open=0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

nmap <F6> :SyntasticCheck<CR>

" Fugitive config
map :gc :Gcommit -a<CR>
map :diff :Gdiff<CR>

" YouCompleteMe config
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf='~/.ycm_global_ycm_extra_conf'
let g:ycm_confirm_extra_conf=0

nmap <F9> :YcmCompleter GoToDefinition<CR>
nmap <F10> :YcmCompleter GoToDeclaration<CR>

" Snipmate config
ino <c-j> <c-r>=TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>

" Language configs
autocmd FileType python call PythonConfig()
autocmd FileType php set tabstop=4
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType perl call PerlConfig()

function! PerlConfig()
	let g:syntastic_perl_checkers=['perl','perlcritic']
	let g:syntastic_perl_lib_path="./lib"
	let g:syntastic_perl_perlcritic_args="--theme corvisa"
	map <F7> :let t = winsaveview()<CR>:%!perltidy<CR>:%!podtidy<CR>:w<CR>:call winrestview(t)<CR>
	map <F8> :!prove -vl<CR>
endfunction

function! PythonConfig()
	set omnifunc=pythoncomplete#Complete
	map <F7> :let t = winsaveview()<CR>:%!pythontidy -c ~/.pythontidy<CR>:w<CR>:call winrestview(t)<CR>
endfunction

