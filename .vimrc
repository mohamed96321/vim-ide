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

" Open new tab with 't'
nnoremap <leader>t :tabnew<CR>

" Open new tab with 'cn'
nnoremap <leader>cn :call ChangeFileNameAndType()<CR>

function! ChangeFileNameAndType()
    let currentFile = expand('%:p')
    let currentFileType = &filetype
    let newName = input('Enter new name for file: ', fnamemodify(currentFile, ':t'))

    if newName != '' && newName != fnamemodify(currentFile, ':t')
        let newPath = input('Enter path (or press Enter for current directory): ', fnamemodify(currentFile, ':p:h'))
        let newFilePath = newPath . '/' . newName

        if newPath == ''
            let newFilePath = newName
        endif

        try
            if !isdirectory(newPath)
                call mkdir(newPath, 'p')
            endif

            execute 'write ' . newFilePath
            execute 'edit ' . newFilePath
        catch
            echomsg 'Error: Unable to save or open the file.'
        endtry
    end
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
let g:prettier#config#tab_width = 2

" Format JavaScript, TypeScript, JSON, CSS, SCSS, Markdown, and other files with Prettier
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json,*.css,*.scss,*.md,*.mjs,*.cjs,*.html,*.yaml,*.yml,*.graphql,*.gql,*.vue,*.svelte silent! :Prettier

" Autopep8 settings
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=120
let g:autopep8_indent_size=2
let g:autopep8_aggressive=1
let g:autopep8_pep8_passes=100
let g:autopep8_pep8_naming=1
let g:autopep8_ignore=1
let g:autopep8_max_aggressive=1
let g:autopep8_use_aggressive_lines=1
let g:autopep8_diff_type='vertical'
let g:autopep8_ignore_invalidintr=1
let g:autopep8_on_save = 1

" Format Python files with Autopep8
autocmd BufWritePre *.py silent! :Autopep8

" vim-autopep8 settings
let g:autopep8_on_save = 1

" Theme settings
colorscheme night-owl
hi Normal ctermbg=none
hi NonText ctermbg=none
hi LineNr ctermbg=none
hi SignColumn ctermbg=none
hi EndOfBuffer ctermbg=none
