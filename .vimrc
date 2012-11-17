" Quita el modo compatible con vi
set nocompatible


" ######## PLUGINS ########
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Edición de texto.
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-scripts/ReplaceWithRegister'

" Navegación por conjuntos de texto.
Bundle 'kana/vim-textobj-user'
Bundle 'kana/vim-textobj-lastpat'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-entire'
Bundle 'kana/vim-textobj-line'
Bundle 'lucapette/vim-textobj-underscore'
Bundle 'kana/vim-smartword'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'nelstrom/vim-visual-star-search'

" Ruby.
Bundle 'vim-ruby/vim-ruby'
Bundle 'jgdavey/vim-blockle'
Bundle 'tpope/vim-endwise'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-rails'
Bundle 'skwp/vim-rspec'
Bundle 'tpope/vim-bundler'

" Git.
Bundle 'gregsexton/gitv'
Bundle 'tpope/vim-fugitive'

" Otros lenguages.
Bundle 'kchmck/vim-coffee-script'
Bundle 'thomd/vim-jasmine'

" Apoyo a varios lenguajes.
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/syntastic'
Bundle 'msanders/snipmate.vim'

" Integración con la shell
Bundle 'mileszs/ack.vim'
Bundle 'epeli/slimux'

" Aspecto.
Bundle 'Lokaltog/vim-powerline'

" Sustituciones.
Bundle 'tpope/vim-abolish'

" Varios.
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/bufkill.vim'

" Plugins no controlados por Vundle
let extra_paths=substitute(glob('~/.vim/bundle-custom/*'), '\n', ',', 'g')
exec 'set runtimepath+=' . extra_paths

" Aumenta el poder del % para if-else-end y más cosas (activa por defecto).
runtime macros/matchit.vim


" ######## ENTORNO ########
set shell=/bin/zsh

" Guarda la configuración de netrw donde debe
let g:netrw_home = '~/.vim'

" Quita la línea extra al final del fichero que añade vim
set noeol
set binary

" Muerte a los números octales.
set nrformats=hex

" La tecla leader por defecto es la \, que está muy lejos.
let mapleader = ","
noremap \ ,

" Por defecto sólo se recuerdan las últimas 20 órdenes. Subimos.
set history=10000

" No expandir a la primera coincidencia de orden automáticamente al dar
" al tabulador, sino listar las posibles
" las opciones que más me gustan son list:longest y list:full
set wildmode=list:longest,full

" Idioma y corrección ortográfica
nm <silent> <leader>k :set spell!<CR>
set spelllang=es_es


" ####### COPIAR Y PEGAR ######
" Pegar a y del sistema
vm <C-y> "+y
nm <C-y> "+gp 
im <C-v> <Esc>"+gp a
inoremap <C-r> <C-r><C-p>

" Seleccionar el último texto copiado o pegado
nm gV `[v`]


" ###### PASAR DE UN MODO A OTRO ######
" Salir con la ñ de modo visual.
vm ñ <C-C>
" Y lo mismo en la línea de órdenes
cm ñ <C-C> 


" ###### ABRIR, CERRAR Y GUARDAR ######
" Grabar archivo tanto en modo normal como en edición
nm ñ :w<CR>
im <C-S> <Esc>:w<CR>a
" Salir del buffer actual, dejando la ventana usando bufkill
nm <Leader>z :BD<CR> 
" Cierra la ventana.
nm <Leader>q :q<CR>
nm <Leader>x :x<CR>
"Dejar sólo el buffer actual
nm <Leader>o :on<CR>
" Abrir ficheros
nm <Leader>e :e<Space>
nm <Leader>v :vsplit<Space>
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
vnoremap <C-j> gj
vnoremap <C-k> gk
nnoremap <C-j> gj
nnoremap <C-k> gk
" 0 es más fácil de teclear que ^ en teclado español, así que intercambio sus
" funciones
nnoremap 0 ^
nnoremap ^ 0
vnoremap 0 ^
vnoremap ^ 0

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
nm <C-N> :bn<CR>
" Editar el buffer que se editaba justo antes de cambiar al actual
nm <C-P> :e #<CR>


" ###### BÚSQUEDAS ######
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
" Busca literal por defecto.
nnoremap / /\V

" ##### SUSTITUCIONES #####
" Repetir la última sustutición conserva los modificadores (:help &)
nnoremap & :&&<CR>
vnoremap & :&&<CR>


" ##### LÍNEA DE ÓRDENES #####
" Buscar el historial de forma incremental sin las flechas
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Ir al principio de línea como en la shell (<C-a> por defecto hace un
" autocompletado inútil).
cnoremap <C-a> <C-b>


" #### INTRODUCIR CARACTERES Y LÍNEAS EN MODO NORMAL ####
" Introducir un carácter antes/después del cursor y volver a modo normal
function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nm s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nm S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Introducir líneas en blanco antes y después de la actual en modo normal
nnoremap - maO<esc>`a
nnoremap + mao<esc>`a


" ###### ASPECTO ######
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

" Cambiar el cursor en Konsole, con o sin tmux.
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\007\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\007\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Powerline
set noshowmode
let g:Powerline_stl_path_style = "short"
" Requiere parchear una tipografía con powerline fontpatcher
let g:Powerline_symbols = "fancy"

" Resaltados de sintaxis en función del tipo de fichero
syntax on
filetype off
filetype plugin indent on
" Sintaxis con espacios
autocmd FileType * setlocal ts=2 sts=2 sw=2 tw=0 expandtab
" Muestra el número de línea
set number
" Muestra el número de línea al final de la pantalla (ya estaba activo por
" defecto)
set ruler
" Por defecto, no contrae las líneas cuando carga un nuevo buffer
set nofoldenable


" ######### RAILS #########
nm <Leader>rm :Rmodel 
nm <Leader>rc :Rcontroller 
nm <Leader>rV :Rview 
nm <Leader>rh :Rhelper 
nm <Leader>rj :Rjavascript 
nm <Leader>rd :Rdecorator
nm <Leader>rvm :RVmodel 
nm <Leader>rvc :RVcontroller 
nm <Leader>rvv :RVview 
nm <Leader>rvh :RVhelper 
nm <Leader>rvj :RVjavascript 
nm <Leader>rvd :RVdecorator
nm <Leader>ra :A<cr>
nm <Leader>rva :AV<cr>
nm <Leader>rr :R<cr>
nm <Leader>rvr :RV<cr>
nm <Leader>rl :Rlayout<cr>
nm <Leader>rS :Rspec 
nm <Leader>rsh :Rspec helpers/
nm <Leader>rsm :Rspec models/
nm <Leader>rsc :Rspec controllers/
nm <Leader>rvS :RVspec 
nm <Leader>rvsh :RVspec helpers/
nm <Leader>rvsm :RVspec models/
nm <Leader>rvsc :RVspec controllers/
nm <Leader>rsr :Rspec requests/
nm <Leader>rvsr :RVspec requests/
nm <Leader>rsu :Rsupport 
nm <Leader>rvsu :RVsupport 
nm <Leader>rsd :Rspec decorators/
nm <Leader>rvsd :RVspec decorators/
" Atajos para tipos de ficheros.
autocmd user Rails Rnavcommand sass app/assets/stylesheets -suffix=.sass
autocmd User Rails Rnavcommand coffee app/assets/javascripts -suffix=.coffee
autocmd User Rails Rnavcommand casmine spec/javascripts/ -glob=**/* -suffix=.coffee
autocmd User Rails Rnavcommand jfixtures spec/javascripts/fixtures -glob=**/* -suffix=.html
autocmd User Rails Rnavcommand support spec/requests/support -glob=**/* -suffix=.rb
autocmd User Rails Rnavcommand factory spec/ -glob=**/* -suffix=actories.rb 
autocmd User Rails Rnavcommand decorator app/decorators -glob=**/* -suffix=_decorator.rb
autocmd User Rails Rnavcommand cell app/cells -glob=**/* -suffix=_cell.rb
autocmd User Rails Rnavcommand cview app/cells -glob=**/* -suffix=.haml
autocmd User Rails Rnavcommand builder app/form_builders -glob=**/* -suffix=.rb


" ######## GIT ########
" atajos para Git
nm <Leader>gs :Gstatus<cr>
nm <Leader>gc :Gcommit<cr>
nm <Leader>gw :Gwrite<cr>
nm <Leader>gr :Gread<cr>
nm <Leader>gd :Gdiff<cr>
nm <Leader>gD :diffoff!<cr><c-w>h:bd<cr>
nm <Leader>ge :Gedit<cr>
nm <Leader>gb :Gblame<cr>
nm <Leader>gl :Glog<cr>
nm <Leader>gv :Gitv --all<cr>
nm <Leader>gV :Gitv! --all<cr>
nm <Leader>gh :Gitv -S
nm <Leader>ga :call Gitv_OpenGitCommand("diff", 'vnew')<cr>
" Cierra los buffers de fugitive automáticamente.
autocmd BufReadPost fugitive://* set bufhidden=delete


" ##### INTEGRACIÓN CON TMUX #####
" Simplifica localizar el directorio del fichero actual.
cnoremap %% <C-R>=expand('%:h').'/'<CR>
cnoremap %<Tab> <C-R>=expand('%:p')<CR>
cnoremap %l<Tab> <C-R>=expand('%:p').':'.line('.')<CR>

nm <Leader>sc :SlimuxShellRun
nm <Leader>sp :SlimuxShellPrompt<CR>
nm <Leader>sr :SlimuxREPLSendLine<CR>
vm <Leader>sr :SlimuxREPLSendSelection<CR>
" Ejecutar test con spin
nm <Leader>ss :SlimuxShellRun spin push %<Tab><CR>
nm <Leader>sl :SlimuxShellRun spin push %l<Tab><CR>

" ###### OTROS PLUGINS ######
" Tabularize
" (requiere tabular, pero si pongo esta condición, no funciona)
nm <Leader>t> :Tabularize /=><CR>
vm <Leader>t> :Tabularize /=><CR>
nm <Leader>t: :Tabularize /:\zs<CR>
vm <Leader>t: :Tabularize /:\zs<CR>
nm <Leader>t, :Tabularize /,\zs<CR>
vm <Leader>t, :Tabularize /,\zs<CR>

" Easymotion
let g:EasyMotion_leader_key = '<Leader>m'

" Tcomment
nm <Leader>c gcc
vm <Leader>c gc

" Syntastic
let g:syntastic_auto_loc_list=1 " Abre automáticamente la lista de errores.

" Gundo
nm <Leader>u :GundoToggle<CR>

" Smartwords
nmap w  <Plug>(smartword-w)
nmap b  <Plug>(smartword-b)
nmap e  <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
vmap w  <Plug>(smartword-w)
vmap b  <Plug>(smartword-b)
vmap e  <Plug>(smartword-e)
vmap ge <Plug>(smartword-ge)

" Ack
nmap <Leader>a :Ack! -i<Space>

" Rspec.
let g:RspecBin = 'rspec'


" ####### VARIOS #######
" Firma de amarok
nm <Leader>f G:r!amarok2-nowplaying<cr>O--<Esc>0k

" Repetir la última orden
nm <Leader>ñ @:

"refrescar vimdiff; se lía a menudo.
nm <Leader>d :diffupdate<cr>

" Configuración local
let fichero_configuracion_local='~/.vimrc.local'
if filereadable(expand(fichero_configuracion_local))
	exec 'source ' . fichero_configuracion_local
endif