" Vanilla configs
set nocompatible

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Enable file type magic (required by many plugins).
filetype on
filetype plugin on
filetype indent on

" Fix syntax highlighting when colors are present.
if &t_Co > 2 || has('gui_running')
	syntax on
	set hlsearch
endif

" Set update tick frequency. Intentionally set high.
set updatetime=60000
set updatecount=400

" Turn on line numbers.
set nu

" Set indentation magic.
set shiftwidth=4
set tabstop=4
set smartindent

" Helpful casing.
set smartcase

" File encoding.
set encoding=utf-8

" Fix for using vim in tmux
if $TERM =~ '^screen-256color'
	map <Esc>OH <Home>
	map! <Esc>OH <Home>
	map <Esc>OF <End>
	map! <Esc>OF <End>
endif

" Clear search results.
command! Clear :let @/ = ""

" Indentation
vmap <Tab> >gv
vmap <S-Tab> <gv

" Reload vim!
nnoremap <leader>rc :source $MYVIMRC<CR>

" Clipboard
vmap <silent> <leader>d d: call system("xclip -i -selection clipboard", getreg("\""))<CR>
vmap <silent> <leader>y y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <silent> <leader>p :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" Plugin configs

" Vundle config
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Github hosted plugins
Bundle 'tpope/vim-fugitive'
Bundle 'othree/html5.vim'
Bundle 'uguu-org/vim-matrix-screensaver'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'c9s/perlomni.vim'
Bundle 'Lokaltog/powerline'
Bundle 'hdima/python-syntax'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'Valloric/YouCompleteMe'
Bundle 'mattn/zencoding-vim'
Bundle 'elzr/vim-json'

" Vim scripts hosted plugins
Bundle 'Wombat'
Bundle 'taglist.vim'
Bundle 'LargeFile'

" Minibufexpl config
nmap <F2> :MBEToggle<CR>
nmap <F3> :MBEbp<CR>
nmap <F4> :MBEbn<CR>
map <Leader>mbf :MBEFocus<CR>

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
let g:ycm_allow_changing_updatetime=0

nmap <F9> :YcmCompleter GoToDefinition<CR>
nmap <F10> :YcmCompleter GoToDeclaration<CR>

" Snipmate config
ino <c-j> <c-r>=TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>

" zencoding config
let g:user_zen_settings = {
			\	'indentation' : '	'
			\}

" Matrix config
function! Idle()
	:MBEClose
	:Matrix
endfunction
" au! CursorHold * nested call Idle()

" LargeFile config
let g:LargeFile = 200 " MB

" Language configs
autocmd FileType python call PythonConfig()
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
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

