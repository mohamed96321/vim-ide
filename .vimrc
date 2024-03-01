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

" set nocompatible " We're running Vim, not Vi!
" syntax on " Enable syntax highlighting
" filetype on " Enable filetype detection
" filetype indent on " Enable filetype-specific indenting
" filetype plugin on " Enable filetype-specific plugins

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
" Plug 'rust-lang/rust.vim'
" Plug 'vim-syntastic/syntastic'
" Plug 'neomake/neomake'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'vim-airline/vim-airline-themes'":AirlineTheme deus
" Plug 'airblade/vim-gitgutter'
" Plug 'scrooloose/nerdcommenter'
" Plug 'sheerun/vim-polyglot'
" Plug 'vimwiki/vimwiki'
" Plug 'w0rp/ale'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'dense-analysis/ale'
" Plug 'udalov/kotlin-vim'
" Plug 'sumneko/lua-language-server', { 'do': ':lua vim.lsp.buf.add_workspace_folder()' }
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug  'vim-ruby/vim-ruby'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', {'do': 'npm install -g prettier'}
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

" Run file in `COMMAND` with 'r'
nnoremap <leader>r :term<Space>

" Close terminal with 'Esc'
tnoremap <Esc> <C-\><C-n>:q!<CR>

" Open new tab with 'n'
nnoremap <leader>n :tabnew<CR>

" Define separator & current_directory as global variables
let g:separator = '/'
let g:current_directory = expand('%:p:h')

" Create and Open new file in new tab with 'c'
nnoremap <leader>c :call CreateAndOpenNewFile()<CR>

function! CreateAndOpenNewFile()
    let fileName = input('Enter filename with extension: ')
    if empty(fileName) || fileName == ''
        echomsg 'Error: Please enter a valid filename.'
        return
    endif

    try
        execute 'tabnew ' . fileName
        echomsg 'New file created and opened: ' . fileName
    catch
        echomsg 'Error: Unable to create or open the file.'
    endtry
endfunction

" Move and rename file with 'cn'
nnoremap <leader>cn :call MoveAndRenameFile()<CR>

function! MoveAndRenameFile()
    let currentFile = expand('%:p')
    let currentFileType = &filetype

    let newName = input('Enter new name for file (press Enter to keep current name): ', fnamemodify(currentFile, ':t'))

    if empty(newName) || newName == ''
        echomsg 'Error: Please enter a new name.'
        return
    endif

    let newPath = input('Enter new path (press Enter to keep current directory): ', fnamemodify(currentFile, ':p:h'))

    try
        if newPath == ''
            echomsg 'Error: Please enter a new path.'
            return
        endif

        let newFilePath = newPath . g:separator . newName

        if newFilePath == currentFile
    	    if filereadable(newFilePath)
                echomsg 'File with the same name already exists in the current directory.'
                return
            endif
            echomsg 'File is already in the specified directory.'
            return
        endif

        if filereadable(newFilePath)
            if newName != '' && newPath != ''
                let options = confirm("File with the same name already exists in the specified directory.\n1- Open the existing file in new tab\n2- Replace the file being moved\n3- Keep all and don't replace", "&Open Existing\n&Replace\n&Keep All", 3)
                if options == 1
                    execute 'tabedit ' . newFilePath
                    return
                elseif options == 2
                    call delete(newFilePath)
                elseif options == 3
                    return
                else
                    echomsg 'Invalid option selected. File not moved.'
                    return
                endif
            elseif newName == '' && newPath != ''
                let overwrite = confirm("File with the same name already exists. Open the existing file?", "&Yes\n&No", 2)
                if overwrite == 1
                    execute 'tabedit ' . newFilePath
                    return
                else
                    echomsg 'File not moved.'
                    return
                endif
            endif
        endif

        if newPath != '' && !isdirectory(newPath)
            call mkdir(newPath, 'p')
        endif

        let moveCommand = 'mv ' . shellescape(currentFile) . ' ' . shellescape(newFilePath)
        call system(moveCommand)
        execute 'edit ' . newFilePath
        echomsg 'Operation successful.'
    catch
        echomsg 'Error: Unable to move or rename the file.'
    endtry
endfunction

" Create directory with 'cd'
nnoremap <leader>cd :call CreateDirectory()<CR>

function! CreateDirectory()
    let folder_name = input('Enter folder name: ')
    if empty(folder_name) || folder_name == ''
        echomsg 'Error: Please enter a valid folder name.'
        return
    endif

    let target_directory = input('Enter the path of directory (or press Enter to use current directory): ', g:current_directory, 'dir')

    if empty(target_directory)
        let target_directory = g:current_directory
    endif

    let full_path = fnamemodify(target_directory . g:separator . folder_name, ':p')

    if isdirectory(target_directory)
        if !isdirectory(full_path)
            call mkdir(full_path, 'p')
            echo 'Folder created: ' . full_path
        else
            echo 'Folder already exists: ' . full_path
        endif
    else
        echo 'Error: Invalid target directory.'
    endif
endfunction

" Create new file in any existing directory with 'cf'
nnoremap <leader>cf :call CreateNewFileInAnyExistingDirection()<CR>

function! CreateNewFileInAnyExistingDirection()
    let newFileName = input('Enter filename with extension: ', '', 'file')
    if empty(newFileName) || newFileName == ''
        echomsg 'Error: Please enter a valid filename.'
        return
    endif

    let existing_directory = input('Enter existing directory: ', g:current_directory, 'file')
    let existing_directory = fnamemodify(existing_directory, ':p:h')

    if isdirectory(existing_directory)
        let newFilePath = fnamemodify(existing_directory . g:separator . newFileName, ':p')
        try
            call writefile([], newFilePath)
            execute 'edit ' . newFilePath
            echomsg 'New file created and opened: ' . newFilePath
        catch
            echomsg 'Error: Unable to create or open the file.'
        endtry
    else
        echomsg 'Error: Invalid directory.'
    endif
endfunction

" Open existing file in directory in a new tab with 'e'
nnoremap <leader>e :call OpenExistingFile()<CR>

function! OpenExistingFile()
    let file_path = input('Open file in an existing directory: ', g:current_directory . g:separator, 'file')

    let expanded_path = fnamemodify(expand(file_path), ':p')
    if !isdirectory(expanded_path) && filereadable(expanded_path)
        try
            execute 'tabedit ' . expanded_path
            echo "Opened: " . expanded_path . " in a new tab."
        catch
            echomsg 'Error: Unable to open the file.'
        endtry
    else
        echo "Error: File does not exist or is a directory: " . expanded_path
    endif
endfunction

" Delete file with 'df'
nnoremap <leader>df :call DeleteFileFromAnyExistingDirection()<CR>

function! DeleteFileFromAnyExistingDirection()
    let fileName = input('Enter filename to delete: ', '', 'file')

    if fileName != ''
        let existing_directory = input('Enter existing directory: ', g:current_directory, 'file')
        let existing_directory = fnamemodify(existing_directory, ':p:h')

        let filePath = fnamemodify(existing_directory . g:separator . fileName, ':p')

        if filereadable(filePath)
            try
                call delete(filePath)
                echomsg 'File deleted: ' . filePath
            catch
                echomsg 'Error: Unable to delete the file. Check file permissions.'
            endtry
        else
            echomsg 'Error: File does not exist at the specified location.'
        endif
    else
        echomsg 'Error: Please enter a valid file name.'
    endif
endfunction

" Delete directory with 'dd'
nnoremap <leader>dd :call DeleteDirectoryFromAnyExistingDirection()<CR>

function! DeleteDirectoryFromAnyExistingDirection()
    let directoryName = input('Enter directory name to delete: ', '', 'dir')

    if directoryName != ''
        let existing_directory = input('Enter existing directory: ', g:current_directory, 'dir')
        let existing_directory = fnamemodify(existing_directory, ':p:h')

        let directoryPath = fnamemodify(existing_directory . g:separator . directoryName, ':p')

        if isdirectory(directoryPath)
            try
                call delete(directoryPath, 'rf')
                echomsg 'The directory with name (' . directoryName . ') deleted'
            catch
                echomsg 'Error: Unable to delete the directory. Check directory permissions.'
            endtry
        else
            echomsg 'Error: Directory does not exist at the specified location.'
        endif
    else
        echomsg 'Error: Please enter a valid directory name.'
    endif
endfunction

" Move to next tab
nnoremap <leader>tn :tabnext<CR>

" Move to previous tab
nnoremap <leader>tp :tabprev<CR>

" Close current tab
nnoremap <leader>tc :tabclose<CR>

" Move The Line Down And Up: Shift + j and Shift + k
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==

" Copy Line Up And Down: Shift + u and Shift + d
nnoremap <S-d> :t .+1<CR>==
nnoremap <S-u> :t .-1<CR>==

" Install rust-analyzer via:CocInstall coc-rust-analyzer

" Lua Unsupported In Windows

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

" Theme settings and enable transparency
colorscheme night-owl
hi Normal ctermbg=none
hi NonText ctermbg=none
hi LineNr ctermbg=none
hi SignColumn ctermbg=none
hi EndOfBuffer ctermbg=none
