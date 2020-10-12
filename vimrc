set nu 			              "sets number 
set nocompatible	          "makes it vi compatible
set hlsearch    	          "highlights search
set ruler 		              "shows cursor position
set showcmd 		          "shows incomplete commands
set history=50  	          "keeps previous 50 commands
set incsearch 		          "Highlights search as you type
set ls=2 		              "sets no. of status lines
set tabstop=4		          "sets tabstop at 2
set softtabstop=2             "for backspace
set expandtab		          "to expand into space
filetype plugin indent on     "auto indentation 
set shiftwidth=2              "for tab
syntax enable                 "for colored syntax
set textwidth=80

"for characters more than 80 characters
call matchadd("ErrorMsg", "\\%>79v.\\+",)


"my remaps
let mapleader = ","
map <leader>i gg=G
vnoremap <c-y> "*y
imap <c-d> <esc>ddi
imap <c-w> <esc>dwi
imap <c-b> <esc>dbi
" imap <c-s> <esc>:w

"my shortcuts
iabbrev iff if(){<CR>}<UP><RIGHT><RIGHT>
iabbrev ife if(){<CR>}else{<CR>}<UP><UP><RIGHT><RIGHT>
iabbrev fr for(;;){<CR>}<UP><RIGHT><RIGHT><RIGHT>
iabbrev wh while(){<CR>}<UP><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>
iabbrev ff const  = function() {<CR>};<UP><RIGHT><RIGHT><RIGHT>



"for indentation
set conceallevel=1
let g:indentLine_conceallevel = 1



"remapped backspace
set backspace=indent,eol,start



" to fold the block
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2


