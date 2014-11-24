" Vanilla configs
set nocompatible

" Make line endings Unix style.
set ff=unix

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

" Turn on line numbers.
set nu

" Set indentation magic.
set shiftwidth=4
set tabstop=4
set noexpandtab
set smartindent

" Helpful casing.
set smartcase
set wildignorecase

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
command! Cls :let @/ = ""

" Indentation
vmap <Tab> >gv
vmap <S-Tab> <gv

" Reload vim!
command! RC :source $MYVIMRC

" Clipboard
vmap <silent> <leader>d d: call system("xclip -i -selection clipboard", getreg("\""))<CR>
vmap <silent> <leader>y y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <silent> <leader>p :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" Better movements (can move over long lines like they're multiple lines).
map j gj
map k gk

map <Up> gk
map <Down> gj

" Allow mapping to the Alt key.
let c='a'
while c <= 'z'
	exec "set <A-".c.">=\e".c
	exec "imap \e".c." <A-".c.">"
	let c = nr2char(1+char2nr(c))
endw

" Move a line of text using Alt+[jk]
nmap <A-j> mz:m+<cr>`z
nmap <A-k> mz:m-2<cr>`z
imap <A-j> <esc><A-j>
imap <A-k> <esc><A-k>
vmap <A-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Enable smart scrolling
set so=5

" Mouse settings
set mouse=a
set ttymouse=xterm

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Kill all trailing whitespace on save
autocmd FileType vim,perl,c,cpp,python,ruby,java autocmd BufWritePre <buffer> :%s/\s\+$//e

" CTags settings

set tags=./tags

" Color the 80th character in a line.
highlight ColorColumn ctermbg=grey guibg=grey
call matchadd('ColorColumn', '\%81v', 100)

" Other search options
set incsearch
set ignorecase
set smartcase

" Set file preferences
set fileformats=unix,mac,dos

" Visual settings
highlight SignColumn ctermbg=black guibg=black

" Mac fixes
set backupskip=/tmp/*,/private/tmp/*

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
Bundle 'elzr/vim-json'
Bundle 'marijnh/tern_for_vim'
Bundle 'vim-scripts/dbext.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'airblade/vim-gitgutter'
Bundle 'benmills/vimux'
Bundle 'ivyl/vim-bling'
Bundle 'groenewege/vim-less'

" Vim scripts hosted plugins
Bundle 'wombat256.vim'
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
let g:Powerline_symbols = 'fancy'

" Tagbar config
nmap <F5> :TagbarToggle<CR>

let g:tagbar_type_perl = {
	\ 'kinds' : [
		\ 'c:constants:1:0',
		\ 'f:formats:1:0',
		\ 'l:labels:0:1',
		\ 'p:packages:1:1',
		\ 's:subroutines:0:1',
		\ 'd:subroutine declartion [off]:1:0',
		\ 'w:roles:1:1',
		\ 'e:extends:1:0',
		\ 'b:bases:1:0',
		\ 't:parents:1:0',
		\ 'u:uses:1:0',
		\ 'r:requires:1:0',
		\ 'a:attributes:0:1',
	\ ]
\ }

" Syntastic config
let g:syntastic_enable_perl_checker=1
let g:syntastic_check_on_open=0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

nmap <F6> :SyntasticCheck<CR>

" Fugitive config
command! GC :Gcommit -a<CR>
command! Diff :Gdiff<CR>

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

" Matrix config
function! Idle()
	:MBEClose
	:Matrix
endfunction
" au! CursorHold * nested call Idle()

" LargeFile config
let g:LargeFile = 50 " MB

" NerdTree config
nmap <F8> :NERDTreeToggle .<CR>

" GitGutter config
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 0

command! Ggt :GitGutterToggle
command! Ggh :GitGutterLineHighlightsToggle

" Eclim config
let g:EclimCompletionMethod = 'omnifunc'

" Theme config

set background=dark
colorscheme wombat256mod

" Language configs
autocmd BufRead,BufNewFile *.t set filetype=perl
autocmd BufRead,BufNewFile *.less set filetype=less

autocmd FileType python call PythonConfig()
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType perl call PerlConfig()
autocmd FileType java call JavaConfig()

function! Perltidy_diff()
	" Work out what the tidied file will be called...
	let perl_file = expand( '%' )
	let tidy_file = perl_file . '.tdy'

	call system( 'perltidy -nst ' . perl_file . ' -o ' . tidy_file )

	" Add the diff to the right of the current window...
	set splitright
	exe ":vertical diffsplit " . tidy_file

	" Clean up the tidied version...
	call delete(tidy_file)
endfunction

function! PerlConfig()
	let g:syntastic_perl_checkers=['perl','perlcritic']
	let g:syntastic_perl_lib_path=['./lib']
	let g:syntastic_perl_perlcritic_args="--theme corvisa"
	map <F7> :let t = winsaveview()<CR>:%!perltidy<CR>:%!podtidy<CR>:w<CR>:call winrestview(t)<CR>
	map <F8> :call Perltidy_diff()<CR>
endfunction

function! PythonConfig()
	set noexpandtab
	set tabstop=4
	set omnifunc=pythoncomplete#Complete
	map <F7> :let t = winsaveview()<CR>:%!pythontidy -c ~/.pythontidy<CR>:w<CR>:call winrestview(t)<CR>
endfunction

function! JavaConfig()
	map <F8> :ProjectTreeToggle<CR>
endfunction

