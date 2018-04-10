" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Feb 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Debug .vimrc
" Set mapleader
let mapleader = ","
" Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
" Fast editing of .vimr :e ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
" When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" vundle setting
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" the following are plugins managed by vundle
" keep Plugin commands between vundle#begin/end
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

" ---------------my configration below-----------------------------------
" show line number
" set number
set numberwidth=5   " minimal number of columns to use for the line number

" 
set list listchars=tab:>.,trail:.,nbsp:.

" Open new splite panes to right and bottom. which feels more natural
" 
set splitbelow
set splitright

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" backup
set nobackup
set nowritebackup
set noswapfile

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
set laststatus=2    " Always display the status line
set autowrite   " Automatically :write before running commands

" tab setting
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab   " axpand tab to space

" Make it abvious where 80 characters is
" set textwidth=80
"set colorcolumn=+1

" Auto complete
inoremap [ []<ESC>i
inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
" inoremap < <><ESC>i
" inoremap { {}<ESC>i
" 
inoremap { {}<ESC>i<CR><ESC>O

" jump out of () etc. and insert in the end of the right part 
inoremap <C-e> <ESC>la

" delete one character in insert mode
inoremap <C-x> <C-o>x
" add one new line and exit it in insert mode
inoremap <C-o> <ESC>o

" quit use Q as q
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Quicker window movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" diff
set diffopt+=vertical

" Taglist (used with ctags) setting(install the plugin taglist by yourself)
let Tlist_Show_One_File = 1 " Does not show tha tags of more than one files.Just show the tags of current file.
let Tlist_Exit_OnlyWindow = 1 "If the window of taglist is teh last window,vim will exit.
let Tlist_Use_Right_Window = 1 "Show the taglist window on the right side.
"let Tlist_Auto_Open = 1 "Auto open taglist when vim start.
map <silent> <leader>t :TlistToggle<cr> "Open and close the taglist window

" Netrw setting (default installed in vim)
let g:netrw_winsize=30
map <silent> <leader>ef :Sexplore!<cr> "Open netrw window in a vertical split window

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
    \   exe "normal! g`\"" |
    \ endif

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

" copy from gvim example_vimrc file
" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey90
  highlight Cursor guibg=Green guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95

endif
