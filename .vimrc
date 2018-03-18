cd /home/anatoly/projects

set keymodel-=stopsel

"
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
set lines=50 columns=100

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
set tabstop=2
set sw=2
set expandtab
set smartindent
set hlsearch




" _ backups {{{
set undodir=~/.vim/tmp/undo//     " undo files
set undofile
set undolevels=3000
set undoreload=10000
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup
set noswapfile
" _ }}}


" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd BufRead,BufNewFile *.haml setlocal foldmethod=indent
autocmd BufNewFile,BufReadPost *.coffee setlocal foldmethod=indent
autocmd BufNewFile,BufReadPost *.rb setlocal foldmethod=syntax
autocmd BufNewFile,BufReadPost *.cpp setlocal foldmethod=syntax
autocmd BufNewFile,BufReadPost *.c setlocal foldmethod=syntax
autocmd BufNewFile,BufReadPost *.slim setlocal foldmethod=indent
autocmd BufNewFile,BufReadPost *.thor setlocal foldmethod=syntax
autocmd BufNewFile,BufReadPost *.go setlocal foldmethod=syntax
autocmd FileType javascript vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.es6 set filetype=javascript
" autocmd BufNewFile,BufRead *.thor set syntax=ruby
autocmd BufNewFile,BufRead *.js setlocal foldmethod=indent
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'leafgarland/typescript-vim'
Plugin 'udalov/kotlin-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'gmarik/Vundle.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'easymotion/vim-easymotion'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'flazz/vim-colorschemes'
call vundle#end()

" Gleb-TV settings"
if executable('/usr/bin/zsh')
  set shell=/usr/bin/zsh
endif
set showcmd
"Search {{{
set ignorecase
set smartcase
set showmatch
set gdefault
set hlsearch
" }}}
"end Gleb-TV settings"
"
syntax on
call pathogen#infect()
syntax enable
filetype plugin indent on
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
set nu
let g:jsx_ext_required=0


nnoremap <C-s> :w<Enter>
inoremap <C-s> <Esc>:w<Enter>
noremap <M-Right> <c-w>l
noremap <M-Left> <c-w>h
noremap <M-Up> <c-w>k
noremap <M-Down> <c-w>j
inoremap <M-Right> <ESC><c-w>l
inoremap <M-Left> <ESC><c-w>h
inoremap <M-Up> <ESC><c-w>k
inoremap <M-Down> <ESC><c-w>j
noremap <silent><F6> :call NERDComment(0, "invert")<cr>
nnoremap <m-c> <C-w>q
nnoremap <C-Up> :.m .-2<Enter>
inoremap <C-Up> <Esc>:.m .-2<Enter>
nnoremap <C-Down> :.m .+1<Enter>
inoremap <C-Down> <Esc>:.m .+1<Enter>
nnoremap <C-v> "+p
inoremap <C-v> <Esc>"+p
vnoremap <C-c> "+y
nnoremap <leader>rv :source $MYVIMRC<cr>
nnoremap <leader>v :split $MYVIMRC<cr>G
nnoremap <leader>z :split ~/.zshrc<cr>G
nnoremap <leader>" ea»<esc>bi«<esc>lel
nnoremap <leader>wt :cd ~/workspaces/Tex<cr>
iabbrev comp const comp = props => (<cr><div><cr></div><cr>);<Esc>2k$a<cr>

let g:Tex_PromptedEnvironments = 'eqnarray*,equation,pmatrix,Proof,Definition,Theorem,enumerate,itemize'
autocmd BufNewFile,BufReadPost *.tex inoremap `o \omega
autocmd BufNewFile,BufReadPost *.tex inoremap `. \frac{\partial -}{\partial <++>}<++><Esc>F-xi
autocmd BufNewFile,BufReadPost *.tex nnoremap `. vT c\frac{\partial <Esc>pa}{\partial -}<++><Esc>F-xi
autocmd BufNewFile,BufReadPost *.tex inoremap `4 \(-\)<++><Esc>F-xi
autocmd BufNewFile,BufReadPost *.tex inoremap `[ \[<cr>-<cr>\]<++><Esc>?-<cr>xi
autocmd BufNewFile,BufReadPost *.tex inoremap ``f \begin{figure}[H]<cr>\centering<cr>\tpximg{-}<cr>\caption{<++>}<cr>\label{fig:<++>}<cr>\end{figure}<++><Esc>?-<cr>xi
