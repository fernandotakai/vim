set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
set rtp+=$GOROOT/misc/vim
call vundle#rc()

 " from github
Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'sjl/gundo.vim'
Bundle 'sjl/threesome.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'duff/vim-scratch'
Bundle 'tpope/vim-repeat'
Bundle 'kevinw/pyflakes-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'SirVer/ultisnips'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'majutsushi/tagbar'
Bundle 'altercation/vim-colors-solarized'
Bundle 'mileszs/ack.vim'
Bundle 'myusuf3/numbers.vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'altercation/vim-colors-solarized'
Bundle 'rodjek/vim-puppet'
Bundle 'tpope/vim-markdown'
Bundle 'jimenezrick/vimerl'
Bundle 'sophacles/vim-bundle-mako'
Bundle 'dogrover/vim-pentadactyl'

" from vimscripts
Bundle 'pthon.vim'
Bundle 'jpythonfold.vim'

set vb
colorscheme mustang

set number
set guifont=Droid\ Sans\ Mono\ Slashed\ for\ Powerline:h12
set relativenumber

set hidden
set backspace=indent,eol,start

set nobackup		
set history=100	
set ruler		
set showcmd		
set incsearch	 
set noswapfile
set scrolloff=5
set ttyfast

set undofile

set undodir=~/.vim/undodir
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
set laststatus=2

if has('mouse')
  set mouse=a
endif

syntax on
set hlsearch

set backupskip=/tmp/*,/private/tmp/*"

au VimResized * :wincmd =

filetype plugin indent on

set tabstop=4
set shiftwidth=4
set expandtab

" fuck you i want my clipboard to be awesome
set clipboard=unnamed

autocmd FileType text setlocal textwidth=79
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

set guioptions-=T
set cot-=preview
set ruler
set nohls

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Search
set incsearch
set ignorecase
set smartcase

" This is done so we can walk around with the cursor
set virtualedit=all
 
nnoremap # :set hlsearch<cr>#
nnoremap / :set hlsearch<cr>/
nnoremap ? :set hlsearch<cr>?
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
nnoremap * *<c-o>

let maplocalleader=','

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

nmap <c-p> <Plug>yankstack_substitute_newer_paste
nmap <c-P> <Plug>yankstack_substitute_older_paste

vmap j gj
vmap k gk
nmap j gj
nmap k gk

nmap <c-m> :nohlsearch<cr>
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

map <Leader>b :MiniBufExplorer<cr>
map <Leader>t :TagbarToggle<CR> 
map <Leader>y :YRShow<cr>
map <Leader>a :Ack 
map <leader>g :GundoToggle<cr>
map <Leader><Tab> :Scratch<cr>
nmap <Leader>c :close<cr>
nmap <Leader>n :NERDTreeToggle<CR>

nnoremap / /\v
vnoremap / /\v

noremap  <Up> <nop>
noremap  <Down> <nop>

" left de-indents a block/line
nmap <Left>   <<
vmap <Left>   <gv

" right indents a block/line
nmap <Right>  >>
vmap <Right>  >gv

" FUCKING MAN GO DIE IN HELL
noremap K <nop>

" ASSHOLE EX MODE NEEDS TO DIE TO. FUCKER.
noremap Q @q

nnoremap <tab> :

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" search buffer by pattern.
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

" splits buffer vertically by number
function! BufVSplit(num)
  execute ":vert sb ". a:num
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")
command! -nargs=1 Vbuff :call BufVSplit("<args>")

map <leader>be :Bs 
map <leader>bv :Vbuff 
map <leader>bs :sbuff 
map <leader>x :BufClose<CR>
map <leader>q :CtrlPBuffer<cr>


" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" ctags
map <silent> <c-]> :set noic<cr>g<c-]><silent>:set ic<cr>

cmap w!! %!sudo tee > /dev/null %
map <Leader>E :Explore<cr>

let g:Powerline_symbols = 'fancy'

let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files', 'find %s -type f']

let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ "libs/|deploy/vendor/|.git/|.hg/|.svn/|.*migrations/" .
    \ ")'"

let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
    \ ctrlp_filter_greps

let my_ctrlp_git_command = "" .
    \ "cd %s && git ls-files | " .
    \ ctrlp_filter_greps

let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]

let g:ctrlp_map = '<leader>p'
let g:ctrlp_extensions = ['tag', 'buffertag']

map <Leader>[ :CtrlPTag<cr>
map <Leader>] :CtrlPBufTag<cr>

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,*.pyc,*.class,*/target/*

" MiniBuff explorer settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

let g:vim_markdown_folding_disabled=1

let g:tagbar_autofocus = 1
let g:tagbar_foldlevel = 0

au BufRead,BufNewFile /usr/local/Cellar/nginx/0.7.65/conf/* set ft=nginx 
au BufNewFile,BufRead *pentadactylrc*,*.penta set filetype=pentadactyl
au BufRead,BufNewFile Vagrantfile set filetype=ruby
au BufRead,BufNewFile *.fish set filetype=fish
au BufRead,BufNewFile *.rc,*.rs set filetype=rust
au BufRead,BufNewFile *.thrift set filetype=thrift
au BufRead,BufNewFile *.spec set filetype=json

au FocusLost * :silent! wall
