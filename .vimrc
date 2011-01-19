" Begin .vimrc

set nocompatible
set bs=2
"set columns=80
set background=dark
set wrapmargin=8
syntax on
set ruler

set backspace=indent,eol,start " make backspace a more flexible
set incsearch "do highlight as you type you 
"set laststatus=2 " always show the status line

nmap . .`[

" Look down the parent folders for tag files
set tags=tags,../tags,../../tags,../../../tags

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

function! s:ResCur()
	if line("'\"") <= line("$")
		execute "normal! g`\""
	endif
endfunction

function! s:UnfoldCur()
	let l:pline = line(".")

	if pline > 1 && &foldenable
		let l:uline = pline - 1
		let l:ufold = foldlevel(uline)
		let l:pfold = foldlevel(pline)

		if ufold > 0
			execute (pfold > ufold ? uline : "") . "normal!  zv"
		endif
	endif
endfunction

augroup jumpCursor
	autocmd!
	if has("folding")
	autocmd BufWinEnter	* call s:ResCur() | call s:UnfoldCur()
	else
	autocmd BufWinEnter	* call s:ResCur()
	endif
augroup END
"
"
"


" End .vimrc
