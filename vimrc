
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Color
Plug 'ajh17/Spacegray.vim'

" Fuzzy file finder
Plug 'kien/ctrlp.vim'

" A tree explorer plugin for vim
Plug 'scrooloose/nerdtree'

" A code-completion engine for Vim need python support
Plug 'Valloric/YouCompleteMe'

" Implements some of TextMate's snippets features in Vim
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Provides a much simpler way to use some motions in vim
Plug 'easymotion/vim-easymotion'

" Displays tags 
Plug 'majutsushi/tagbar'

" Automatic closing of quotes, parenthesis, brackets
Plug 'Raimondi/delimitMate'

" Vim plugin that allows you to visually select increasingly larger 
" regions of text using the same key combination
Plug 'terryma/vim-expand-region'

" Buffer tabs
" Multiple select
Plug 'terryma/vim-multiple-cursors'

" Tern plugin for vim
Plug 'ternjs/tern_for_vim'

" Vim go
" Plug  'fatih/vim-go'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Settings                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "'"
nnoremap ; :

set nu
syntax on
set t_Co=256
color spacegray
set ruler
set nobackup
imap jj <Esc>
set cursorline

set autoindent noexpandtab tabstop=4 shiftwidth=4
set list
set listchars=eol:¬,tab:\▸\ ,trail:~,extends:>,precedes:<

set foldmethod=indent
set foldlevelstart=99
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Gui Settings                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
	set guifont=Monaco:h14
	set guioptions-=T
	set guioptions-=m
	set guioptions-=r
	set guioptions-=L
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Plugin Settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree
map <C-e> :NERDTreeToggle<CR>

" easymontion
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" tagbar
map <C-i> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" vim-expand-region
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" YouCompleteMe
let g:ycm_confirm_extra_conf=0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_complete_in_comments = 1
let g:ycm_filetype_blacklist = {
			\ 'tagbar' : 1,
			\ 'nerdtree' : 1,
			\}

" vim-buftabline
set hidden
nnoremap <C-h> :bnext<CR>
nnoremap <C-q> :bw<CR>

" Fix YouCompleteMe & Ultisnips conflict
function! g:UltiSnips_Complete()
	call UltiSnips#ExpandSnippet()
	if g:ulti_expand_res == 0
		if pumvisible()
			return "\<C-n>"
		else
			call UltiSnips#JumpForwards()
			if g:ulti_jump_forwards_res == 0
				return "\<TAB>"
			endif
		endif
	endif
	return ""
endfunction

function! g:UltiSnips_Reverse()
	call UltiSnips#JumpBackwards()
	if g:ulti_jump_backwards_res == 0
		return "\<C-P>"
	endif

	return ""
endfunction

if !exists("g:UltiSnipsJumpForwardTrigger")
	let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
	let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

