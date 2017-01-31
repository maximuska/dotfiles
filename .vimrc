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
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set wildmenu      " nicer tab completions

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set tildeop              " wait for the motion command after '~' case conversion operator

set nobackup
set noswapfile

" Note: vim-sleuth plugin may override these (https://github.com/tpope/vim-sleuth)
set tabstop=4     " a tab is four spaces
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set expandtab     " Don't insert tabs, use spaces

set gdefault      " Ussume 'g' flag by default for :s

" Setting leader key, obviously
" The idea to use space is from: https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader="\<Space>"

"set clipboard=unnamed " Yank into system clipboard (this allows using 'Shift-Ins' to paste in insert mode ;)

" Togling smart indent when pasting code. Start in 'set paste' as a default.
"set paste
set pastetoggle=<F10>

" Omni completion provides smart autocompletion for programs. To use omni completion, type <C-X><C-O> while open in Insert mode
" http://vim.wikia.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

" Save buffer before doing other stuff (e.g., running external commands)
set autowrite

" Detect external buffer modification and autoupdate the file
set autoread

" Clear current search highlight -- a bit annoying, may be I should adjust keys timeout.
"nnoremap <esc> :noh<return><esc>

" Filetype plugin indent on
autocmd filetype python set expandtab

"set t_Co=256
"if &t_Co >= 256 || has("gui_running")
"    colorscheme desert256
"    let g:solarized_termcolors=256
"    colorscheme solarized
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

" Jumping to beginning/end of the outer block, useful in e.g., HTML
nnoremap ]t vatatv
nnoremap [t vatatov

" Hitting enter in command mode disables the last search highlighting
nnoremap <CR> :noh<CR><CR>

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
nmap <C-x>g :call GitGrepWord()<CR>
nmap <leader>gg :Ggrep! -w <cword><cr>

" 'Global' integration
map <C-\>^] :GtagsCursor<CR>

nmap <leader>l :TagbarToggle<CR>

nmap <leader>w :w<CR>
"nmap <leader>q :wqa<CR>
nmap <leader>d :bd<CR>

" Map '' to jump to the last line+column
nmap '' `'

" Quit all windows (overriding 'enter ex mode')
map Q :qa<CR>

" 'Stop that stupid window from popping up'
" (https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/)
map q: :q

" Swap full/partial word search semantics of '*'. Don't like '/' register to
" be cluttered with word boundary symbols: '</'.
nnoremap * g*
nnoremap g* *

" Change the 'completeopt' option so that Vim's popup menu doesn't select the
" first completion item, but rather just inserts the longest common text of
" all matches; and the menu will come up even if there's only one match.
" Also, scratch preview window is not shown.
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
" Keep menu item always highlighted by simulating <Up> on pu visible
inoremap <expr> <C-p> pumvisible() ? '<C-p>' :
  \ '<C-p><C-r>=pumvisible() ? "\<lt>Up>" : ""<CR>'
" Map 'Enter' to select current menu item, as Ctrl-Y does
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Customize behaviour in vimdiff mode
if &diff
    "colorscheme evening
    "map Q :cquit<CR>   "quit with an error code

    " Fix the difficult-to-read default setting for diff text highlighting.  The
    " bang (!) is required since we are overwriting the DiffText setting. The highlighting
    " for "Todo" also looks nice (yellow) if you don't like the "MatchParen" colors.
    " highlight! link DiffText MatchParen " simple one-liner
    " highlight! link DiffText TODO

    " Override diff colors to specific values. Color-scheme specific, works fine with the default one.
    " http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim?file=Xterm-color-table.png
    " http://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
    highlight DiffAdd    cterm=bold ctermfg=13 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffDelete cterm=bold ctermfg=13 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffChange cterm=bold ctermfg=13 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffText   cterm=bold ctermfg=13 ctermbg=23 gui=none guifg=bg guibg=Red
endif

" Make :find searching recursively
" http://stackoverflow.com/questions/3554719/find-a-file-via-recursive-directory-search-in-vim
":set path+=**

" Mapping keys for 'vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Gitgutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Teach 'ctrlp' to use git ls-files when available
let g:ctrlp_use_caching = 1 " F5 to refresh quickly
let g:ctrlp_lazy_update = 200 " Delay updates up to 200ms
let g:ctrlp_by_filename = 0
let g:ctrlp_default_input = 1
let g:ctrlp_regexp = 0
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_root_markers = ['../leia']
" if executable('ag')
"     set grepprg=ag\ --nogroup\ --nocolor

"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" else
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"   let g:ctrlp_prompt_mappings = {
"     \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
"     \ }
" endif

" Use C++ style comments in C files
autocmd FileType c setlocal commentstring=//\ %s

" Recognize XIV templates as .c header
autocmd BufRead,BufNewFile *.xh set filetype=c

" AUtomatically open quickfix window following grep invocations
autocmd QuickFixCmdPost *grep* cwindow

" Airline bar customization
let g:airline#extensions#tabline#enabled = 1 " Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#whitespace#enabled = 0 " Disable builtin whitespace extension
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" Highlight trailing whitespaces using 'error' color (http://www.bestofvim.com/tip/trailing-whitespace/)
match ErrorMsg '\s\+$'

" Patagen plugins manager
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()
filetype plugin indent on

" End .vimrc
