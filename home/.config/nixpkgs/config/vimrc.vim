"      _              
" __ _(_)_ __  _ _ __ 
" \ V / | '  \| '_/ _|
"  \_/|_|_|_|_|_| \__|
"                     

" Set the location of the vim config
    let vimrc='~/.config/nixpkgs/config/vimrc.vim'
" Set the default leader from backslash
    let mapleader=','
" Basic
    set nocompatible
    filetype plugin indent on
    syntax on
    set encoding=utf-8
    set number relativenumber
    set cursorline
    set backspace=indent,eol,start
    set autoread
    set linebreak
    set showbreak=>>
    set showmatch
" Allow color schemes to do bright colors without forcing bold.
    set t_Co=16
" Always show at least one more line at the bottom
    set scrolloff=1
    set sidescrolloff=5
    set display+=lastline
" Indentation
    set smartindent
    set expandtab
    set shiftwidth=4
    set tabstop=4
" Autocompletion
    set wildmode=longest,list,full
" Disables automatic commenting on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Spell-check set to <Leader>o, 'o' for 'orthography':
    map <Leader>o :setlocal spell! spelllang=en_gb<CR>
" Splits open at the bottom and right
    set splitbelow splitright
" Make navigating between splits easier
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
" Make it easy to open configs
    nmap <Leader>ev :execute "tabedit ".vimrc<cr>
    nmap <Leader>en :tabedit ~/.config/nixpkgs<cr>
" Incremental highlighted search results
    set hlsearch
    set incsearch
    set smartcase
    set ignorecase
" Turn off highlighting for search results
    nmap <Leader><space> :nohlsearch<cr>
" Disable arrow keys for navigation. hjkl force
    nmap <Left> <<
    nmap <Right> >>
    vmap <Left> <gv
    vmap <Right> >gv
    noremap <Up> <Nop>
    noremap <Down> <Nop>
" Move lines using Ctrl+Up/Down in normal, insert and visual modes
    nnoremap <C-Up> :m-2<CR>
    nnoremap <C-Down> :m+<CR>
    inoremap <C-Up> <Esc>:m-2<CR>
    inoremap <C-Down> <Esc>:m+<CR>
    vnoremap <C-Up> :m '<-2<CR>gv=gv
    vnoremap <C-Down> :m '>+1<CR>gv=gv
    " or Ctrl+j/k
    nnoremap <C-j> :m .+1<CR>==
    nnoremap <C-k> :m .-2<CR>==
    inoremap <C-j> <ESC>:m .+1<CR>==gi
    inoremap <C-k> <ESC>:m .-2<CR>==gi
    vnoremap <C-j> :m '>+1<CR>gv=gv
    vnoremap <C-k> :m '<-2<CR>gv=gv
" Run any command as a silent one (background)
    command! -nargs=1 Silent
    \   execute 'silent !' . <q-args>
    \ | execute 'redraw!'
" Generate a list of numbers
    command! -nargs=1 List
    \   execute 'put =map(range(<q-args>), 'printf(''%04d'', v:val)')'
" Copy to system clipboard alias
    nmap <C-c> "+y
    nmap <C-x> "+d
" Limelight config
    let g:limelight_conceal_ctermfg = 'gray'
    let g:limelight_conceal_ctermfg = 240
    let g:limelight_conceal_guifg = 'DarkGray'
    let g:limelight_conceal_guifg = '#777777'
    let g:limelight_bop = '^.*$'
    let g:limelight_eop = '\n'
    let g:limelight_paragraph_span = 0
    let g:limelight_priority = -1
" Limelight Goyo.vim integration
    autocmd! User GoyoEnter Limeligh
    autocmd! User GoyoLeave Limelight!
" Airline settings
    let g:airline_theme='deus'
" Rainbow parantheses
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
" Clear Fireplace history
    nmap <Leader>cfh :unlet! g:FIREPLACE_HISTORY<cr>
" C
    autocmd FileType c set cindent
    let g:ale_completion_enabled = 1
    let g:ale_linters = {'c': ['gcc', 'clangtidy', 'clang-format']}
    let g:ale_c_gcc_executable = 'gcc'
    let g:ale_c_gcc_options = '-std=c99 -Wall -Wextra -pedantic'
    let g:ale_c_clang_executable = 'gcc'
    let g:ale_c_clang_options = '-std=c99 -Wall -Wextra -pedantic'
    let g:ale_c_clangtidy_executable = 'clang-tidy'
    let g:ale_c_clangtidy_options = '-std=c99 -Wall -Wextra -pedantic'

" Notes
" - 'zz' centers the line where the cursor is located
" - '<C-]>' takes us to the definition of the tag
" - ':Silent' <cmd> runs any given <cmd> as a silent one
" - ci( ChangesInsideBracket, di{ DeletesInsideParanthesis, vi' visually select inside '
" - '<C-W-O>' makes the current buffer fullscreen
" - ':n' when listing files to create a new file
" - '<C-y-,>' expands Emmet tags
" - '<Leader>b' turns on word wrapping
