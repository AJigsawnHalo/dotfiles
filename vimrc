syntax on 


" General options
set path=.,/usr/include/,,**
set tabstop=4
set softtabstop=4
set number
set relativenumber
set showcmd
set cursorline
filetype plugin indent on
set lazyredraw
set showmatch
set hlsearch
set ic
set laststatus=2
set splitright
set splitbelow
set nocompatible
set viminfo='100,<50,s10,h,%
set shiftwidth=4
set ttimeout
set ttimeoutlen=100
set foldlevelstart=5
set timeoutlen=3000
set noshowmode 
let maplocalleader= "\<Space>"
"if has('win64')
"	set shell=pwsh.exe
"endif


" Gui options
if has('gui_running')
	set guifont=Source\ Code\ Pro\ 9
	set guioptions -=T
	set guioptions -=m
	set guioptions -=L
	set guioptions -=r
	set lines=50 columns=150
endif

" Custom Commands
command Qmake !qmake
command CdAkltn cd ~/Projects/Aklatan/Devel
command CdWiki cd ~/Wiki

" Custom Keybinds
nnoremap <leader><space> :nohlsearch<CR> 
map <C-o> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
nnoremap <leader>t :sp <Bar> terminal<CR>
nnoremap <leader>vt :vert terminal<CR>
nnoremap <leader>nt :tabnew<CR>
nnoremap <leader>ycm :YcmGenerateConfig<CR>
"" Rust keybinds
nnoremap <leader>cr :!cargo run<CR>
nnoremap <leader>cb :!cargo build<CR>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gv :vsp<CR><Plug>(coc-definition)
nmap <silent> <leader>gs :sp<CR><Plug>(coc-definition)

" Autocommands
" autocmd terminal
augroup terminal_settings
    autocmd!
	autocmd TermOpen term://* startinsert
    autocmd BufLeave term://* stopinsert

    " Ignore various filetypes as those will close terminal automatically
    " Ignore fzf, ranger, coc
    autocmd TermClose term://*
          \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
          \   call nvim_input('<CR>')  |
          \ endif
  augroup END 
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"" autocmd NERDTREE
""" Start NERDTree when Vim is started without file arguments.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | wincmd p | endif
""" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
""" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
""" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror


" Plugin Options     plug-opt

" i3conf syntax detection
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/regolith/i3/config set filetype=i3config
aug end

" vimwiki settings
let wiki_notes = {} 
let wiki_notes.path = '~/Wiki/'
let wiki_notes.syntax = 'markdown'
let wiki_notes.ext = '.md'
let wiki_writing = {}
let wiki_writing.path = '~/Projects/writing/'
let wiki_writing.syntax = 'markdown'
let wiki_writing.ext = '.md'

let g:vimwiki_list = [wiki_notes,wiki_writing]
"let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'default', 'ext': '.wiki'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_folding='expr'


" instant-markdown settings
"set shell=bash\ -i
map <leader>md :InstantMarkdownPreview<CR>
"let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1 
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1

" lightline.vim settings
let g:lightline = {
      \ 'colorscheme': 'hybrid',
      \ }

let g:tex_flavor = 'latex'

" YCM Options
let g:ycm_python_interpreter_path = '/usr/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1

" CoC.nvim options
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" Calendar-vim options
let g:calendar_wruler = 'Mo Tu We Th Fr Sa Su'
"let g:calendar_first_day='monday'
"let g:calendar_google_calendar = 1
"let g:calendar_google_task = 1

" Orgmode options
let g:org_agenda_files = ['~/Dropbox/wiki/org/tasks.org', '~/Dropbox/wiki/org/events.org', '~/Dropbox/wiki/projects/notpad.org']
let g:org_todo_keywords=['TODO', 'PROGRESS', 'BLOCKED', 'REVIEW', '|', 'DONE', 'ARCHIVED', 'CANCELLED']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Vim-Plug Plugins     vim-plug
call plug#begin('~/.vim/plugged')

" lightline.vim
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'cocopon/lightline-hybrid.vim'

" Vimwiki
Plug 'vimwiki/vimwiki'

" Vim-instant-markdown
Plug 'suan/vim-instant-markdown'
" Qt support for vim
Plug 'https://github.com/fedorenchik/qt-support.vim.git'

" Nerdtree
Plug 'https://github.com/scrooloose/nerdtree.git'

" Vim-obsession. For saving vim sessions
Plug 'https://github.com/tpope/vim-obsession'

" Bufexplorer
Plug 'jlanzarotta/bufexplorer'

" Vim-orgmode and dependencies
Plug 'jceb/vim-orgmode'
Plug 'https://github.com/tpope/vim-speeddating'
"Plug 'git://github.com/mattn/calendar-vim'
"Plug 'git://github.com/itchyny/calendar.vim'
Plug 'https://github.com/inkarkat/vim-SyntaxRange'
Plug 'vim-scripts/utl.vim'

" Rainglow - 320+ Colors
Plug 'rainglow/vim'

" Vimtex - LaTeX Plugin
Plug 'lervag/vimtex'

" YouCompleteMe
"Plug 'ycm-core/YouCompleteMe'
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" coc.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'} 

Plug 'cespare/vim-toml'

Plug 'https://github.com/zigford/vim-powershell.git'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'kevinoid/vim-jsonc'
Plug 'ghifarit53/tokyonight-vim'
call plug#end()

" Colorschemes
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
set termguicolors
colorscheme tokyonight
set t_Co=256

