" General settings
syntax enable
set number
set relativenumber
set mouse=a
set encoding=UTF-8
set ruler
set laststatus=2

" Indentation settings
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set cinwords=if,elif,else,for,while,try,except,finally,def,class
filetype plugin indent on

" Set the leader key to comma
let mapleader = ","

" Plugin settings
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tc50cal/vim-terminal'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', {'do': 'npm install'}
Plug 'tell-k/vim-autopep8'
Plug 'haishanh/night-owl.vim'
Plug 'Exafunction/codeium.vim'
call plug#end()

" vim-airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" vim-surround settings
autocmd FileType * setlocal ts=4 sts=4 sw=4 expandtab
nmap ds ds"
nmap cs c"
nmap ys ysiw"
nmap yS ysiw"
nmap yss yss"

" vim-commentary settings
nmap gcc :Commentary<CR>
xmap gcc :Commentary<CR>

" vim-terminal settings
let g:terminal_width = 120

" nerdtree settings
nnoremap <C-n> :NERDTreeToggle<CR>

" Select all in normal mode with Ctrl + a
nnoremap <C-a> ggVG

" Open file explorer with 'pv'
nnoremap <leader>pv :Ex<CR>

" Open terminal with 't' and use vi <filename.type> not vim
nnoremap <leader>t :term<CR>

" Run file in `COMMAND` with 'te'
nnoremap <leader>te :term<Space>

" Close terminal with 'Esc'
tnoremap <Esc> <C-\><C-n>:q!<CR>

" Create and Open new file in new tab with 'c'
nnoremap <leader>c :call CreateAndOpenNewFile()<CR>

function! CreateAndOpenNewFile()
    let fileName = input('Enter filename with type: ')
    if empty(fileName)
        echomsg 'Error: Please enter a valid filename with type.'
        return
    endif

    try
        execute 'tabnew ' . fileName
        echomsg 'New file created and opened: ' . fileName
    catch
        echomsg 'Error: Unable to create or open the file.'
    endtry
endfunction

" Create and Open new file in new tab with 't'
" nnoremap <leader>t :tabnew<Space>

" Move and rename file with 'cn'
nnoremap <leader>cn :call MoveAndRenameFile()<CR>

function! MoveAndRenameFile()
    let currentFile = expand('%:p')
    let currentFileType = &filetype

    let newName = input('Enter new name for file (press Enter to keep current name): ', fnamemodify(currentFile, ':t'))
    let newPath = input('Enter new path (press Enter to keep current directory): ', fnamemodify(currentFile, ':p:h'))

    try
        if newName == '' && newPath == ''
            echomsg 'Error: Please enter a new name or a new path.'
            return
        endif

        let newFilePath = newPath . '/' . (newName != '' ? newName : fnamemodify(currentFile, ':t'))

        if newFilePath == currentFile
            echomsg 'Error: The file is already in the specified directory.'
            return
        endif

        if filereadable(newFilePath)
            echomsg 'Error: File with the same name already exists in the specified directory.'
            return
        endif

        if newPath != '' && !isdirectory(newPath)
            call mkdir(newPath, 'p')
        endif

        call rename(currentFile, newFilePath)
        execute 'edit ' . newFilePath
        echomsg 'File moved and opened: ' . newFilePath
    catch
        echomsg 'Error: Unable to move or open the file.'
    endtry
endfunction

" Create folder with 'd'
nnoremap <leader>d :call CreateFolder()<CR>

function! CreateFolder()
    let current_directory = expand('%:p:h')
    let create_folder = input('Create Folder: ', current_directory . '/')

    " Check if the folder already exists
    if !isdirectory(create_folder)
        call mkdir(create_folder, 'p')
        echo 'Folder created: ' . create_folder
    else
        echo 'Folder already exists: ' . create_folder
    endif
endfunction

" Open existing file in a new tab with 'o'
nnoremap <leader>o :call OpenExistingFile()<CR>

" Function to open existing files in a new tab
function! OpenExistingFile()
    let current_directory = expand('%:p:h')
    let file_path = input('Open file in a new tab in existing directory: ', current_directory . '/')

    let expanded_path = expand(file_path)
    if !isdirectory(expanded_path) && !filereadable(expanded_path)
        echo "Error: File or directory does not exist: " . expanded_path
        return
    endif

    try
        execute 'tabedit ' . expanded_path
        echo "Opened: " . expanded_path . " in a new tab."
    catch
        echomsg 'Error: Unable to open the file.'
    endtry
endfunction

" Move to next tab
nnoremap <leader>tn :tabnext<CR>

" Move to previous tab
nnoremap <leader>tp :tabprev<CR>

" Close current tab
nnoremap <leader>tc :tabclose<CR>

" coc.nvim settings
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-python',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-java',
      \ 'coc-clangd',
      \ 'coc-css',
      \ 'coc-yaml',
      \ 'coc-lua',
      \ 'coc-go',
      \ ]

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" Prettier settings
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#tab_width = 4

" Format JavaScript, TypeScript, JSON, CSS, SCSS, Markdown, and other files with Prettier
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json,*.css,*.scss,*.md,*.mjs,*.cjs,*.html,*.yaml,*.yml,*.graphql,*.gql,*.vue,*.svelte silent! :Prettier

" Autopep8 settings
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=120
let g:autopep8_indent_size=4
let g:autopep8_aggressive=1
let g:autopep8_pep8_passes=100
let g:autopep8_pep8_naming=1
let g:autopep8_ignore=1
let g:autopep8_max_aggressive=1
let g:autopep8_use_aggressive_lines=1
let g:autopep8_diff_type='vertical'
let g:autopep8_ignore_invalidintr=1
let g:autopep8_on_save = 1

" Autopep8 on save with a
autocmd BufWritePost *.py :Autopep8

" Theme settings and enable transparency
colorscheme night-owl
hi Normal ctermbg=none
hi NonText ctermbg=none
hi LineNr ctermbg=none
hi SignColumn ctermbg=none
hi EndOfBuffer ctermbg=none
