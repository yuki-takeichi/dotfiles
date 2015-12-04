" autocmdをリセット (http://vim-users.jp/2009/09/hack74/)
autocmd! 
set nocompatible

let lisp_rainbow = 1
let mapleader = " "

set hidden
set nobackup		" do not keep a backup file, use versions instead

set colorcolumn=80

noremap ; :



"""""""""""""""""""
" Tab by filetype "
"""""""""""""""""""
set shiftwidth=2 tabstop=2 expandtab " default settings 
" http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
autocmd FileType perl setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType go setlocal shiftwidth=4 tabstop=4 expandtab


"""""""""""
" Plugins "
"""""""""""
filetype off
set rtp+=~/.vim/bundle/vundle/ " run time path
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'vimgdb'
Plugin 'thinca/vim-quickrun'
Plugin 'Shougo/vimproc'
Plugin 'vim-rooter'
Plugin 'vim-perl/vim-perl'
Plugin 'hotchpotch/perldoc-vim'
Plugin 'Shougo/neocomplcache'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'go.vim'
Plugin 'plantuml-syntax'
Plugin 'fatih/vim-go'
Plugin 'ghcmod'
Plugin 'ag.vim'
Plugin 'https://github.com/dleonard0/pony-vim-syntax'

call vundle#end()
filetype plugin indent on


"""""""""""""""
" Search Path "
"""""""""""""""
" 初期値をロード (http://vim-users.jp/2009/09/hack74/)
set path& 
set wildignore&

set path+=./lib
set wildignore+=.git/

set path+=** " :find works recursively!!

"""""""""""""""
" Appearances "
"""""""""""""""
syntax enable
set number
set background=light
colorscheme solarized
" https://github.com/nathanaelkane/vim-indent-guides/issues/4
autocmd VimEnter * :IndentGuidesEnable
autocmd VimEnter * :hi IndentGuidesOdd ctermbg=lightgrey
autocmd VimEnter * :hi IndentGuidesEven ctermbg=white


"""""""""""""""""""""
" Current Directory "
"""""""""""""""""""""
let g:rooter_manual_only = 1
let g:rooter_use_lcd = 1
let g:rooter_patterns = ['Rakefile', 'cpanfile', '.git/']
autocmd BufEnter *.rb,*.pm,*.pl :Rooter


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


"""""""""""""
" Quick Run "
"""""""""""""
let g:quickrun_config = {}

" runnerをvimprocに設定
let g:quickrun_config['_'] = {
            \ 'runner': 'vimproc',
            \ "runner/vimproc/updatetime" : 100
            \ }

" perl on carton
let g:quickrun_config['perl/carton'] = {
            \   'cmdopt': '-Ilib',
            \   'exec': 'carton exec perl %o %s:p %a'
            \ }

" perl prove on carton
let g:quickrun_config['perl/carton/prove'] = {
            \   'cmdopt': '-Ilib -It/inc',
            \   'exec': 'carton exec prove -vcfrm --timer --trap %o %s:p %a'
            \ }
            "\   'exec': 'carton exec prove -r -Ilib -It/inc --harness TAP::Harness::JUnit %a'

" ruby on bundle
let g:quickrun_config['ruby'] = {
            \   'cmdopt': '-Ilib',
            \   'exec': 'ruby %o %a %s:p'
            \ }

" ruby on bundle
let g:quickrun_config['ruby/bundle'] = {
            \   'cmdopt': '-Ilib',
            \   'exec': 'bundle exec ruby %o %a %s:p'
            \ }

let g:quickrun_config['ruby/bundle/test'] = {
            \   'cmdopt': '-Ilib:test',
            \   'exec': 'bundle exec ruby %o %a %s:p'
            \ }
"""""""""""""
" Syntastic "
"""""""""""""

let g:syntastic_enable_signs = 1
let g:syntastic_perl_checkers = ['perl', 'perlcritic', 'podchecker']
let g:syntastic_enable_perl_checker = 1

" Perl's security issue
" https://github.com/scrooloose/syntastic/blob/master/syntax_checkers/perl/perl.vim#L59
"let g:syntastic_perl_lib_path = [ './lib' ]
"let g:syntastic_perl_interpreter = 'carton exec perl'
let g:syntastic_perl_lib_path = [ './lib', './t/lib', './t/inc', './local/lib/perl5' ]
let g:syntastic_perl_interpreter = 'perl'

let g:syntastic_perl_perlcritic_args = "--harsh"

let g:syntastic_java_javac_classpath = './*'


""""""""""""""""""
" Editing .vimrc "
""""""""""""""""""
command! MyVimRC vsplit $MYVIMRC
autocmd BufWritePost .vimrc source %


"""""""""""""""""""""
" Buffer Management "
"""""""""""""""""""""
" bdの代替コマンド(bdだとWindowが閉じてしまう)
command! BB bp | bd # "buffer backspace
" バッファリストを素早く出す
nnoremap <C-l> :ls<CR>
