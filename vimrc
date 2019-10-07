syntax on 

" Colorschemes
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme hybrid
set t_Co=256
set termguicolors

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

if has('gui_running')
	set guifont=Source\ Code\ Pro\ 10
	set guioptions -=T
	set guioptions -=m
	set guioptions -=L
	set guioptions -=r
	set lines=42 columns=150
endif

" keybinds
nnoremap <leader><space> :nohlsearch<CR> 
map <C-o> :NERDTreeToggle<CR>
nnoremap <leader>t :bel terminal<CR>
nnoremap <leader>vt :vert terminal<CR>
nnoremap <leader>ycm :YcmGenerateConfig<CR>

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
let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "sh":1,
			\ "zsh":1,
			\ "python":1,
			\ }
let g:ycm_python_interpreter_path = '/usr/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1

" Calendar-vim options
let g:calendar_wruler = 'Mo Tu We Th Fr Sa Su'

" Orgmode options
let g:org_agenda_files = ['~/Dropbox/wiki/org/tasks.org', '~/Dropbox/wiki/org/events.org']
let g:org_todo_keywords=['TODO', 'PROGRESS', 'BLOCKED', 'REVIEW', '|', 'DONE', 'ARCHIVED', 'CANCELLED']

" Vim-Plug Plugins
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
Plug 'git://github.com/tpope/vim-obsession.git'

" Bufexplorer
Plug 'jlanzarotta/bufexplorer'

" Vim-orgmode and dependencies
Plug 'jceb/vim-orgmode'
Plug 'https://github.com/tpope/vim-speeddating'
Plug 'git://github.com/mattn/calendar-vim'
"Plug 'git://github.com/itchyny/calendar.vim'
Plug 'https://github.com/inkarkat/vim-SyntaxRange'
Plug 'vim-scripts/utl.vim'

" Rainglow - 320+ Colors
Plug 'rainglow/vim'

" Vimtex - LaTeX Plugin
Plug 'lervag/vimtex'

" YouCompleteMe
Plug 'ycm-core/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
call plug#end()

set noshowmode 
let maplocalleader= "\<Space>"
