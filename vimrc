" Plugin configs

" Pathogen config
execute pathogen#infect()

" Minibufexpl config
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1

" Powerline config
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2
set t_Co=256

" Tagbar config
nmap <F2> :TagbarToggle<CR>

" Vanilla configs
set updatetime=10000
set updatecount=400

set guioptions-=T

set nu

set shiftwidth=4
set tabstop=4
set autoindent

set encoding=utf-8

" Language configs
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType php set tabstop=4
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags noci
autocmd FileType perl call PerlConfig()

function! PerlConfig()
	map <F3> :let t = winsaveview()<CR>:%!perltidy<CR>:%!podtidy<CR>:w<CR>:call winrestview(t)<CR>
endfunction

