"usage
set paste
set autoindent
set smartcase

" size of a hard tabstop
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
retab

"env styling
set number
set statusline+=col:\ %c
set ruler
syntax on

"split prefs
set splitbelow
set splitright

"detemine...
set showmatch
set hlsearch
set incsearch
set scrolloff=5
set laststatus=2
" duplicate? set statusline=%n\ %f%=%l\\%l

"key mappings
nnoremap ; :nohlsearch<CR>
nnoremap <F3> :NumbersToggle<CR>
set pastetoggle=<F2>

"python remove trailing whitespace
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
"python highlighting extras
let python_highlight_all = 1

" questionable additions
" set smarttab
" set copyindent
" set shiftround
" set visualbell
" set noerrorbells
" set ignorecase

