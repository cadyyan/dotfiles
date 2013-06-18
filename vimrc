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
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_perl_checkers=['perl','perlcritic']
let g:syntastic_perl_perlcritic_args="--theme corvisa"

nmap <F6> :SyntasticCheck<CR>

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
	map <F7> :let t = winsaveview()<CR>:%!perltidy<CR>:%!podtidy<CR>:w<CR>:call winrestview(t)<CR>
endfunction

