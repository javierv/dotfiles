" Quita el modo compatible con vi
set nocompatible

" Plugins con vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'jgdavey/vim-blockle'
Bundle 'tpope/vim-endwise'
Bundle 'kchmck/vim-coffee-script'
Bundle 'thomd/vim-jasmine'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'msanders/snipmate.vim'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-rails'
Bundle 'epeli/slimux'
Bundle 'tpope/vim-unimpaired'
Bundle 'sjl/gundo.vim'
Bundle 'gregsexton/gitv'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
" Mejor tcomment que NERDCommenter.
Bundle 'tomtom/tcomment_vim'
" Me gusta más syntastic que checksyntax
Bundle 'scrooloose/syntastic'

" Aumenta el poder del % para if-else-end y más cosas (activa por defecto).
runtime macros/matchit.vim

"Quita la línea extra al final del fichero que añadie vim
set noeol
set binary

" La tecla leader por defecto es la \, que está muy lejos.
let mapleader = ","

" Por defecto sólo se recuerdan las últimas 20 órdenes. Subimos.
set history=100

" Pegar a y del sistema
vmap <C-y> "+y
nmap <C-y> "+gp 
im <C-v> <Esc>"+gp a

" Seleccionar el último texto copiado o pegado
nmap gV `[v`]

" Repetir la última orden
nnoremap <Leader>ñ @:

" No expandir a la primera coincidencia de orden automáticamente al dar
" al tabulador, sino listar las posibles
" las opciones que más me gustan son list:longest y list:full
set wildmode=list:longest,full

" Idioma y corrección ortográfica
nmap <silent> <leader>q :set spell!<CR>
set spelllang=es_es

" Firma de amarok
nmap <Leader>f G:r!amarok2-nowplaying<cr>O--<Esc>0k

"refrescar vimdiff; se lía a menudo.
nnoremap <Leader>d :diffupdate<cr>

" ###### ABRIR, CERRAR Y GUARDAR
" Salir del modo edición (la letra Esc está muy lejos)
im Ñ <Esc>
" Lo mismo para salir del modo visual
vn Ñ <C-C>
" Grabar archivo tanto en modo normal como en edición
nm ñ :w<CR>
im <C-S> <Esc>:w<CR>a
" Salir del buffer actual
nnoremap <Leader>z :bd<CR> 
"Dejar sólo el buffer actual
nnoremap <Leader>o :on<CR>
"
" Recupera la línea del fichero en la que estaba la última vez que se editó
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" Permite quitar el buffer de la ventana aunque no se haya grabado
set hidden
" Directorios donde se guardan todos los archivos swp y backups
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp


" ###### NAVEGACIÓN ######
" Navegación por líneas.
" Atajos para navegar cuando las líneas están cortadas
vn <C-j> gj
vn <C-k> gk
nmap <C-j> gj
nmap <C-k> gk
" 0 es más fácil de teclear que ^ en teclado español, así que intercambio sus
" funciones
nnoremap 0 ^
nnoremap ^ 0
vn 0 ^
vn ^ 0

" Marcas
" ' es más útil que ` porque te lleva también a la columna, no sólo a la línea
nnoremap ' `
nnoremap ` '

" Navegación entre ventanas
nm <tab> <C-W>w
nm <S-tab> <C-W>W
" Abrir ventanas a la derecha en vez de a la izquierda
" y abajo en vez de arriba
set splitright
set splitbelow
" Navegación entre buffers
nm <C-tab> :bn<CR>
nm <C-S-tab> :bp<CR>
nm <C-N> :bn<CR>
" Editar el buffer que se editaba justo antes de cambiar al actual
nm <C-P> :e #<CR>

" Navegación entre etiquetas
nmap <CR> <C-]>

" ###### BÚSQUEDAS ####
" Resalta el primer resultado de la búsqueda según tecleas
set incsearch
" Resalta todas las coincidencias de la búsqueda
set hlsearch 
" Quita el resaltado de las coincidencias (lo vuelve a poner en la siguiente
" búsqueda)
nm ç :nohlsearch<CR>
" No diferencia buscar mayúsculas y minúsculas salvo que se escriba alguna
" mayúscula set ignorecase
set ignorecase
set smartcase


" #### INTRODUCIR CARACTERES Y LÍNEAS EN MODO NORMAL ####
" Introducir un carácter antes/después del cursor y volver a modo normal
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nm s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nm S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Introducir líneas en blanco antes y después de la actual en modo normal
nm - maO<esc>`a
nm + mao<esc>`a


" ###### ASPECTO #######
if has("gui_running")
  " Ajusta el tamaño de la ventana en gvim
  set lines=200 columns=200
  " Elimina las barras de edición y los menús
  set guioptions-=m
  set guioptions-=T
  colorscheme railscasts " railscasts, nuvola, los summerfruit y mac_classic son candidatos.
else
  colorscheme mynuvola " nuvola, summerfruit256 y mac_classic son los candidatos.
endif
" Incluye el título en la ventana (gvim lo hace automáticamente)
set title
" Incluye siempre la ruta del fichero que se edita
set laststatus=2
" Resaltados de sintaxis en función del tipo de fichero
syntax on
filetype off
filetype plugin indent on
" Sintaxis con espacios
autocmd FileType * setlocal ts=2 sts=2 sw=2 tw=0 expandtab
" No muestra el número de línea
set nonumber
" Muestra el número de línea al final de la pantalla (ya estaba activo por
" defecto)
set ruler
" Indica que una línea es continuación de la anterior
set showbreak=...
" Por defecto, no contrae las líneas cuando carga un nuevo buffer
set nofoldenable


" ######### RAILS ############
nnoremap <Leader>rm :Rmodel 
nnoremap <Leader>rc :Rcontroller 
nnoremap <Leader>rV :Rview 
nnoremap <Leader>rh :Rhelper 
nnoremap <Leader>rj :Rjavascript 
nnoremap <Leader>rd :Rdecorator
nnoremap <Leader>rvm :RVmodel 
nnoremap <Leader>rvc :RVcontroller 
nnoremap <Leader>rvv :RVview 
nnoremap <Leader>rvh :RVhelper 
nnoremap <Leader>rvj :RVjavascript 
nnoremap <Leader>rvd :RVdecorator
nnoremap <Leader>ra :A<cr>
nnoremap <Leader>rva :AV<cr>
nnoremap <Leader>rr :R<cr>
nnoremap <Leader>rvr :RV<cr>
nnoremap <Leader>rl :Rlayout<cr>
nnoremap <Leader>rS :Rspec 
nnoremap <Leader>rsh :Rspec helpers/
nnoremap <Leader>rsm :Rspec models/
nnoremap <Leader>rsc :Rspec controllers/
nnoremap <Leader>rvS :RVspec 
nnoremap <Leader>rvsh :RVspec helpers/
nnoremap <Leader>rvsm :RVspec models/
nnoremap <Leader>rvsc :RVspec controllers/
nnoremap <Leader>rsr :Rspec requests/
nnoremap <Leader>rvsr :RVspec requests/
nnoremap <Leader>rsu :Rsupport 
nnoremap <Leader>rvsu :RVsupport 
nnoremap <Leader>rsd :Rspec decorators/
nnoremap <Leader>rvsd :RVspec decorators/
" Atajos para tipos de ficheros.
autocmd User Rails Rnavcommand sass app/assets/stylesheets -suffix=.sass
autocmd User Rails Rnavcommand coffee app/assets/javascripts -suffix=.coffee
autocmd User Rails Rnavcommand casmine spec/javascripts/ -glob=**/* -suffix=.coffee
autocmd User Rails Rnavcommand jfixtures spec/javascripts/fixtures -glob=**/* -suffix=.html
autocmd User Rails Rnavcommand support spec/requests/support -glob=**/* -suffix=.rb
autocmd User Rails Rnavcommand factory spec/ -glob=**/* -suffix=actories.rb 
autocmd User Rails Rnavcommand decorator app/decorators -glob=**/* -suffix=_decorator.rb
autocmd User Rails Rnavcommand cell app/cells -glob=**/* -suffix=_cell.rb
autocmd User Rails Rnavcommand cview app/cells -glob=**/* -suffix=.haml


" ######### GIT ##############
"vimdiff current vs git head (fugitive extension)
nnoremap <Leader>gd :Gdiff<cr>
"switch back to current file and closes fugitive buffer
nnoremap <Leader>gD :diffoff!<cr><c-w>h:bd<cr>
" atajos para Git
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gw :Gwrite<cr>
nnoremap <Leader>gr :Gread<cr>
nnoremap <Leader>ge :Gedit<cr>
nnoremap <Leader>gl :Glog<cr>
nnoremap <Leader>gv :Gitv<cr>
nnoremap <Leader>gV :Gitv!<cr>
nnoremap <Leader>gh :Gitv -S
nnoremap <Leader>ga :call Gitv_OpenGitCommand("diff", 'vnew')<cr>

" Tabularize
" (requiere tabular, pero si pongo esta condición, no funciona)
nmap <Leader>t> :Tabularize /=><CR>
vmap <Leader>t> :Tabularize /=><CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>
nmap <Leader>t, :Tabularize /,\zs<CR>
vmap <Leader>t, :Tabularize /,\zs<CR>

" Easymotion
let g:EasyMotion_leader_key = '<Leader>m'

" Tcomment
nm <Leader>c gcc
vm <Leader>c gc

" Syntastic
let g:syntastic_auto_loc_list=1 " Abre automáticamente la lista de errores.

" Gundo
nnoremap <Leader>h :GundoToggle<CR>

" ##### INTEGRACIÓN CON TMUX #####
function! FileName()
  return expand('%:p')
endfunction

nmap <Leader>sr :SlimuxShellRun
nmap <Leader>sc :SlimuxShellConfigure<CR>
vmap <Leader>sr :SlimuxREPLSendSelection<CR>
" Ejecutar test con spin
nmap <Leader>ss :<C-U>exec "SlimuxShellRun spin push ".FileName()<CR>
nmap <Leader>sl :<C-U>exec "SlimuxShellRun spin push ".FileName().":".line('.')<CR>