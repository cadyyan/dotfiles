" Vanilla configs
set nocompatible

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\ 	exe "normal! g`\"" |
		\ endif

	augroup END

	augroup debian
		au BufRead reportbug-*		set ft=mail
	augroup END
else
	set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" Set paper size from /etc/papersize if available (Debian-specific)
if filereadable("/etc/papersize")
  let s:papersize = matchstr(readfile('/etc/papersize', '', 1), '\p*')
  if strlen(s:papersize)
    exe "set printoptions+=paper:" . s:papersize
  endif
endif

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

set nobackup

filetype on
filetype plugin on
filetype indent on

set updatetime=10000
set updatecount=400

set nu

set shiftwidth=4
set tabstop=4
set smartindent

set smartcase

set encoding=utf-8

:command Clear :let @/ = "";

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
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_global_ycm_extra_conf='~/.ycm_global_ycm_extra_conf'
let g:ycm_confirm_extra_conf=0

nmap <C-[> :YcmCompleter GoToDefinition<CR>
nmap <C-]> :YcmCompleter GoToDeclaration<CR>
nmap <C-\> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Language configs
autocmd FileType python call PythonConfig()
autocmd FileType php set tabstop=4
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType perl call PerlConfig()

function! PerlConfig()
	let g:syntastic_perl_checkers=['perl','perlcritic']
	let g:syntastic_perl_perlcritic_args="--theme corvisa"
	map <F7> :let t = winsaveview()<CR>:%!perltidy<CR>:%!podtidy<CR>:w<CR>:call winrestview(t)<CR>
	map <F8> :!prove -vl<CR>
endfunction

function! PythonConfig()
	set omnifunc=pythoncomplete#Complete
	map <F7> :let t = winsaveview()<CR>:%!pythontidy -c ~/.pythontidy<CR>:w<CR>:call winrestview(t)<CR>
endfunction

