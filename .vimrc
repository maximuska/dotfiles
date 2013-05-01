" Begin .vimrc

set nocompatible
set bs=2
set background=dark
set wrapmargin=8
set ruler
set hidden

" Look down the parent folders for tag files
set tags=tags,../tags,../../tags,../../../tags

" Enable filetype plugins
filetype plugin on

" Inspired by: http://nvie.com/posts/how-i-boosted-my-vim/
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set matchtime=3   " (for showmatch)
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set wildmenu      " nicer tab completions

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

set expandtab    " Don't insert tabs, use spaces

"set clipboard=unnamed " Yank into system clipboard (this allows using 'Shift-Ins' to paste in insert mode ;)

" Togling smart indent when pasting code.
set pastetoggle=<F10>

" Clear current search highlight -- a bit annoying, may be I should adjust keys timeout.
"nnoremap <esc> :noh<return><esc>

" Filetype plugin indent on
autocmd filetype python set expandtab

"if &t_Co >= 256 || has("gui_running")
"   colorscheme mustang
"endif

if &t_Co > 2 || has("gui_running")
   " switch syntax highlighting on, when the terminal has colors
   syntax on
endif

" Vim can highlight whitespaces for you in a convenient way:
" For more info, see :h listchars.
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
" In some files, like HTML and XML files, tabs are fine and showing them is really annoying..
" autocmd filetype html,xml set listchars-=tab:>.

" Use ; to switch to command mode instead of :.
" nnoremap ; :

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" Make up&down work more naturally when moving in wrapped lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Typing w!! saves the file with 'sudo'
cmap w!! w !sudo tee % >/dev/null

" map control-backspace to delete the previous word
imap <C-BS> <C-W>

" map C-right/left to jump text in various modes on my terminal (could I use termcap?)
imap <Esc>[1;5C <C-O>w
nmap <Esc>[1;5C w
imap <Esc>[1;5D <C-O>b
nmap <Esc>[1;5D b

" Pressing Tab on the command line will show a menu to complete buffer and
" file names. From: http://vim.wikia.com/wiki/Easier_buffer_switching
set wildchar=<Tab> wildmenu wildmode=full

" If you are still getting used to Vim and want to force yourself to stop using the arrow keys, add this:
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" Restore cursor to file position in previous editing session
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" 
" Tell vim to remember certain things when we exit
"  '10  :	marks will be remembered for up to 10 previously edited files
"  "100 :	will save up to 100 lines for each register
"  :20  :	up to 20 lines of command-line history will be remembered
"  %    : 	saves and restores the buffer list
"  n... : 	where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" This will jump to the last position in the visited files
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" git grep mapping for vi
" http://vim.wikia.com/wiki/Git_grep
"  Find the pattern :G <pattern> -- '*.c'
func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

"  Find the word under the cursor when hitting Ctrl+X G
func GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
nmap <C-x>G :call GitGrepWord()<CR>


" End .vimrc
