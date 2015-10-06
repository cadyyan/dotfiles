" Disable Vi compatibility
set nocompatible
filetype off



" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()



" Plugin setup
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'airblade/vim-gitgutter'
Plugin 'ivyl/vim-bling'
Plugin 'Valloric/YouCompleteMe'
Plugin 'durandj/bazel.vim'

call vundle#end()
filetype plugin indent on



" Setup vanilla Vim settings
if !has('gui_running')
	set t_Co=256 " Make sure we have the full range of colors
endif

scriptencoding utf-8 " Ensure scripts load in UTF-8 format

syntax on " Turn on syntax highlighting

" Set the Sign column color
highlight SignColumn ctermbg=black guibg=black

" Setup the invisible characters
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

set backspace=indent,eol,start       " Allow backspacing over everything
set backupskip=/tmp/*,/private/tmp/* " Skip backups on certain files
set encoding=utf8                    " Set file encoding to UTF-8
set fileformats=unix,mac,dos         " Set file format preferences
set ff=unix                          " Set line endings to Unix style
set ignorecase                       " Ignore case when searching
set incsearch                        " Enable incremental search
set list                             " Show invisible characters
set laststatus=2                     " Turn on the status bar
set listchars=tab:▸\ ,eol:¬          " Show invisibles
set noexpandtab                      " Don't expand tabs into spaces
set nu                               " Turn on line numbers
set shiftwidth=4                     " Set the tab width
set smartcase                        " Allow special case sensitive searches
set smartindent                      " Set smart indent mode
set so=5                             " Enable smart scrolling
set tabstop=4                        " Set the tab width
set wildignorecase                   " Ignore case when searching

" Set the font
set guifont=Sauce\ Code\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ Plus\ Pomicons

" Setup the color scheme
set background=dark
colorscheme solarized




" Hotkeys/shortcuts

" Indent visual selection
vnoremap <Tab> >gv

" Remove indent from visual selection
vnoremap <S-Tab> <gv

" Clear search selection
command! Cls :let @/ = ""

" Reload Vim settings
command! RC :source $MYVIMRC

" Copy/Paste from system clipboard
let s:uname = system("uname")
if s:uname == "Darwin\n"
	let copyCmd = "pbcopy"
	let pasteCmd = "pbpaste"
else
	let copyCmd = "xclip -i -selection clipboard"
	let pasteCmd = "xclip -o -selection clipboard"
endif

vnoremap <silent> <leader>d d: call system(copyCmd, getreg("\""))<CR>
vnoremap <silent> <leader>y y: call system(copyCmd, getreg("\""))<CR>
nnoremap <silent> <leader>p :call setreg("\"",system(pasteCmd))<CR>p

" Better movements (can move over long lines like they're multiple lines).
noremap j gj
noremap k gk
noremap <Up> gk
noremap <Down> gj

nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj

" Allow mapping to the Alt key.
let c='a'
while c <= 'z'
	exec "set <A-".c.">=\e".c
	exec "imap \e".c." <A-".c.">"

	let c = nr2char(1+char2nr(c))
endw

" Move a line of text using Alt+[jk]
nnoremap <A-j> mz:m+<cr>`z
nnoremap <A-k> mz:m-2<cr>`z
inoremap <A-j> <esc><A-j>
inoremap <A-k> <esc><A-k>
vnoremap <A-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Kill all trailing whitespace on save
autocmd FileType vim,perl,c,cpp,python,ruby,java,js,jsx,css
	\ autocmd BufWritePre <buffer> :%s/\s\+$//e

" Color the 80th column
set colorcolumn=80



" Plugin settings

" Lightline
let g:lightline = {
	\ 'colorscheme': 'solarized',
	\ 'active': {
		\ 'left': [
			\ ['mode', 'paste'],
			\ ['fugitive', 'filename'],
		\ ],
		\ 'right': [
			\ ['syntastic', 'lineinfo'],
			\ ['percent'],
			\ ['fileformat', 'fileencoding', 'filetype'],
		\ ],
	\ },
	\ 'component_function': {
		\ 'fileencoding': 'LightLineFileencoding',
		\ 'fileformat': 'LightLineFileFormat',
		\ 'filename': 'LightLineFilename',
		\ 'filetype': 'LightLineFiletype',
		\ 'fugitive': 'LightLineFugitive',
		\ 'mode': 'LightLineMode',
	\ },
	\ 'component_expand': {
		\ 'syntastic': 'SyntasticStatuslineFlag',
	\ },
	\ 'component_type': {
		\ 'syntastic': 'error',
	\ },
	\ 'separator': {'left': '⮀', 'right': '⮂'},
	\ 'subseparator': {'left': '⮁', 'right': '⮃'},
\ }

function! LightLineFileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineFileformat()
	return winwidth(0) > 70 ?
		\ (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightLineFilename()
	let fname = expand('%:t')

	return fname =~ 'NERD_tree' ? '' :
		\ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
		\ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
		\ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ?
		\ &filetype . ' ' . WebDevIconsGetFileTypeSymbol() :
		\ 'no ft') : ''
endfunction

function! LightLineFugitive()
	try
		if expand('%:t') !~? 'NERD' && exists('*fugitive#head')
			let mark = ''
			let _ = fugitive#head()

			return strlen(_) ? mark._ : ''
		endif
	catch
	endtry

	return ''
endfunction

function! LightLineMode()
	let fname = expand('%:t')

	return fname =~ 'NERD_tree' ? 'NERDTree' :
		\ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineModified()
	if &filetype == "help"
		return ""
	elseif &modified
		return "+"
	elseif &modifiable
		return ""
	else
		return ""
	endif
endfunction

function! LightLineReadonly()
	if &filetype == "help"
		return ""
	elseif &readonly
		return "⭤"
	else
		return ""
	endif
endfunction



" MiniBufExpl
nnoremap <F2> :MBEToggle<CR>
nnoremap <F3> :MBEbp<CR>
nnoremap <F4> :MBEbn<CR>
noremap <Leader>mbf :MBEFocus<CR>

" Disable the buffer numbers
let g:miniBufExplShowBufNumbers = 0


" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1



" EasyTags
let g:easytags_async = 1



" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0



" NerdTree
noremap <F5> :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif



" Language settings
autocmd FileType python call PythonConfig()

function! PythonConfig()
	set tabstop=4

	set noexpandtab
endfunction

