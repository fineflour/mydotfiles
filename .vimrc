" ==========================================================
" Vundle settings
" ==========================================================
set nocompatible				" be iMproved
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle								" required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rake'
Plugin 'int3/vim-extradite'

Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'mattn/emmet-vim'
Plugin 'AutoTag'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/ZoomWin'
Plugin 'scrooloose/syntastic'
Plugin 'kana/vim-fakeclip'
Plugin 'jgdavey/tslime.vim'
" Plugin 'vim-pandoc/vim-pandoc'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ngmy/vim-rubocop'
Plugin 'flazz/vim-colorschemes'
Plugin 'rizzatti/dash.vim'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'JSON.vim'
Plugin 'ruby-matchit'
Plugin 'matchit.zip'
" Plugin 'textobj-rubyblock'
" Plugin 'godlygeek/tabular'
"
" vim-scripts repos
" Plugin 'L9'
" Plugin 'FuzzyFinder'

" non-GitHub repos
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'kana/vim-textobj-user.git' 

" All this stuff is for snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install (update) bundles
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused bundle

" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Vundle commands are not allowed.

" All plugins must be added before the following line
call vundle#end()						" required
filetype plugin indent on		" required

" ==========================================================
" Ruby settings
" ==========================================================
syntax on
syntax enable
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

"Colors
set background=light
colorscheme Tomorrow-Night "desert

" fakeclip settings
let g:fakeclip_terminal_multiplexer_type = 'tmux'

" ctrl_p ignore folders
let g:ctrlp_custom_ignore =  'tags\|bin\|tmp\|log\:coverage'
set tags=./tags;/

" rubocop settings
"let vimrubocop_config='config/rubocop/rubocop.yml'

"using ag (the silver searcher) with ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

let mapleader =","

" Pretify JSON
map <leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>
au BufRead,BufNewFile *.json set filetype=json

" zoom in/out of vim window
map <Leader>z <C-w>o

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Git blame
map <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Open edit command at current directory
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>

" Fix indents on entire file
map <Leader>ii mmgg=G`m<CR>

" Paste from clipboard with proper indentation
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

" Set up vim to copy text
map <Leader>co :set nonu nornu<CR>,n<CR>

" ...
map <Leader>nco :set nu rnu<CR>,n<CR>

" Timelapse?
map <leader>h :call TimeLapse() <cr> 

" tmux-runner

"from Chris Toomey's dotfiles (test these out)
let g:VtrClearBeforeSend = 0
let g:VtrUseVtrMaps = 1
let g:VtrGitCdUpOnOpen = 0
let g:VtrPercentage = 30

nnoremap <leader>sd :VtrSendCommand<cr>
nnoremap <Leader>fr :VtrFocusRunner<cr>
nnoremap <leader>va :VtrAttachToPane<cr>

nmap <leader>fs :VtrFlushCommand<cr>:VtrSendCommandToRunner<cr>
nmap <C-f> :VtrSendLineToRunner<cr>
vmap <C-f> <Esc>:VtrSendSelectedToRunner<cr>

nnoremap <leader>rj :VtrSendCommandToRunner be rake konacha<cr>
nnoremap <leader>rs :VtrSendCommandToRunner rake<cr>

nmap <leader>osr :VtrOpenRunner {'orientation': 'h', 'percentage': 50}<cr>
nnoremap <leader>pry :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'pry'}<cr>

nnoremap <leader>sd :VtrSendCTRLD<cr>
nnoremap <leader>q :VtrSendCommandToRunner <cr>
nnoremap <leader>sf :w<cr>:call SendFileViaVtr()<cr>
nnoremap <leader>sl :VtrSendCommandToRunner <cr>

function! SendFileViaVtr()
  let runners = {
    \ 'haskell': 'ghci',
    \ 'ruby': 'ruby',
    \ 'javascript': 'node',
    \ 'python': 'python',
    \ 'sh': 'sh'
    \ }
  if has_key(runners, &filetype)
    let runner = runners[&filetype]
    let local_file_path = expand('%')
    execute join(['VtrSendCommandToRunner', runner, local_file_path])
  else
    echoerr 'Unable to determine runner'
  endif
endfunction

" let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
" let g:rspec_command = 'call Send_to_Tmux("bin/rspec {spec}\n")'

" vim-rspec config
" zsh version
let g:rspec_command = "VtrSendCommandToRunner! bin/rspec -fp -t ~skip {spec}"

" bash version
" let g:rspec_command = \"VtrSendCommandToRunner! bin/rspec -fp -t ~skip {spec}"

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>g :call RunAllSpecs()<CR>

" To run in last session of current iTerm terminal
"let g:rspec_runner = "os_x_iterm"

set noswapfile " remove swap file feature

" Colors
set background=dark
colorscheme Tomorrow-Night

set history=500

set nocompatible   " Turn off compatibility with VI.
set modelines=0    "Turn modelines off in files; turn on if needed.

"Set tab stops
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set ruler
set relativenumber
set ttyfast
set autoread
set more
set cursorline!
set smarttab

"From http://stevelosh.com/blog/2010/09/coming-home-to-vim/#why-i-came-back-to-vimset scrolloff=3
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set hidden
set wildmenu
set wildmode=list:longest

"set visualbell
set cursorline							"Add cursor line
set ttyfast
hi Visual term=reverse cterm=reverse guibg=Grey

set ruler								"Set ruler
set showcmd

set backspace=indent,eol,start
set laststatus=2
set number						"set current line number on ruler
set relativenumber				"Set relative numbers on ruler
set undofile					"Create undo file for undoing even after closing file


set autowrite		    "Save buffers when I switch out of them?


set clipboard+=unnamed  " use the clipboards of vim and win
set paste               " Paste from a windows or from vim
set go+=a               " Visual selection automatically copied to the clipboard


" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()

function! Stab()
    let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
    if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
    endif
    call SummarizeTabs()
endfunction

function! SummarizeTabs()
    try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts
        if &l:et
            echon ' expandtab'
        else
            echon ' noexpandtab'
        endif
    finally
        echohl None
    endtry
endfunction

"NERDTree mappings
map <leader>n :NERDTreeToggle<CR><CR>

"These help with search. Case ignored unless search string has
"uppercase anywhere

set ignorecase
set smartcase
set gdefault			"global search by default

"Highligh search as you type
noremap % v%
set incsearch
set showmatch
set hlsearch
set matchtime=4

"Clear out search with leader space
nnoremap <leader><space> :noh<cr>

"Make tab key match bracket pairs
nnoremap <tab> %

"Handling long lines better
"set wrap
"set textwidth=79
"set formatoptions=qrn1
"set colorcolumn=85

"TextMate-style invisible characters
"set list
"set listchars=tab:▸\ ,eol:¬

"Saves file when focus is lost
"au FocusLost * :wa

"###########Mappings###########

"Remap exiting  instert mode (Esc)
inoremap jj <esc>

" Unrap the arrow keys (to get used to not using them in insert mode)
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
"nnoremap  j gj
"nnoremap k gk

"##### Leader key mappings
"Shortcut to rapidly toggle 'set list'
nmap <leader>l :set list!<CR>

"Strip all trailing whitespaces in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/='<CR>

"Use <leader>w to open a new vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Ack
nnoremap <leader>a :Ack

" Map 'ft' to 'fold tag' function
nnoremap <leader>ft Vatzf

" Smart CSS with <leader>S
"nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" re-hardwrap paragraphs of text (like TextMate)
"nnoremap <leader>q gqip

" Use <leader>v to re-select the text that was just pasted
nnoremap <leader>v V`]


" Quick Vim window resizing
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>++ :exe "vertical resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>-- :exe "vertical resize " . (winheight(0) * 2/3)<CR>

" Use <leader>ev to open up .vimrc in a vertical split for modifying on the fly
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" Zoom / Restore window.
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
      execute t:zoom_winrestcmd
      let t:zoomed = 0
  else
      let t:zoom_winrestcmd = winrestcmd()
      resize
      vertical resize
      let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>
" map to <leader><leader>
map <leader>z :ZoomToggle<CR>


" Vim Splits mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Vim Split - More natural split openings
set splitbelow
set splitright

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%



set path+=~/code
set path+=.
