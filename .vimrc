" Incluye los plugins en .vim/bundle/
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" Quita el modo compatible con vi
set nocompatible
" Aplica los cambios del .vimrc automáticamente
" autocmd bufwritepost .vimrc source $MYVIMRC (la comento porque incluir esto
" cuelga gvim al guardar el fichero, por razón que desconozco)

if has("gui_running")
  " Ajusta el tamaño de la ventana en gvim
  set lines=200 columns=200
  " Elimina las barras de edición y los menús
  set guioptions-=m
  set guioptions-=T
  colorscheme railscasts " railscasts, nuvola, los summerfruit y mac_classic son candidatos.
else
  colorscheme nuvola " nuvola, summerfruit256 y mac_classic son los candidatos.
endif
" Esquema de colores
" Incluye el título en la ventana (gvim lo hace automáticamente)
set title
" Por defecto sólo se recuerdan las últimas 20 órdenes. Subimos.
set history=100
" Directorios donde se guardan todos los archivos swp y backups
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" Por defecto ya está activa, pero lo pongo para decirlo. Aumenta el poder
" del % para if-else-end y más cosas
runtime macros/matchit.vim

" Pegar a y del sistema
vmap <C-y> "+y
nmap <C-y> "+gp 
im <C-v> <Esc>"+gp a

" Atajos para navegar cuando las líneas están cortadas
" Los atajos para g0 y g$ no parecen funcionar
vn <C-j> gj
vn <C-k> gk
nmap <C-j> gj
nmap <C-k> gk

" Resaltados de sintaxis en función del tipo de fichero
syntax on
filetype off
filetype plugin indent on
" Autocompletado
" im <S-Space> <C-N>

function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction

" La tecla leader por defecto es la \, que está muy lejos.
let mapleader = ","

" Repetir la última orden
nnoremap <Leader>ñ @:

" Firma de amarok
nmap <Leader>f G:r!amarok2-nowplaying<cr>O--<Esc>0k

" Salir del modo edición (la letra Esc está muy lejos)
im Ñ <Esc>
" Lo mismo para salir del modo visual
vn Ñ <C-C>
" Grabar archivo tanto en modo normal como en edición
nm <C-S> :w<CR>
nm ñ :w<CR>
im <C-S> <Esc>:w<CR>a
" Salir del buffer actual
nnoremap <Leader>z :bd<CR> 
"Dejar sólo el buffer actual
nnoremap <Leader>o :on<CR>

" 0 es más fácil de teclear que ^ en teclado español, así que intercambio sus
" funciones
nnoremap 0 ^
nnoremap ^ 0
vn 0 ^
vn ^ 0
" ' es más útil que ` porque te lleva también a la columna, no sólo a la línea
nnoremap ' `
nnoremap ` '

" Introducir un carácter antes/después del cursor y volver a modo normal 
nm s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nm S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
" Introducir líneas en blanco antes y después de la actual en modo normal
nm - maO<esc>`a
nm + mao<esc>`a

" Unimpaired by Tim Pope: mover líneas de posición
nnoremap <silent> <Plug>unimpairedMoveUp :<C-U>exe 'norm m`'<Bar>exe 'move--'.v:count1<CR>``
nnoremap <silent> <Plug>unimpairedMoveDown :<C-U>exe 'norm m`'<Bar>exe 'move+'.v:count1<CR>``
xnoremap <silent> <Plug>unimpairedMoveUp :<C-U>exe 'norm m`'<Bar>exe '''<,''>move--'.v:count1<CR>``
xnoremap <silent> <Plug>unimpairedMoveDown :<C-U>exe 'norm m`'<Bar>exe '''<,''>move''>+'.v:count1<CR>``
nmap [e <Plug>unimpairedMoveUp
nmap ]e <Plug>unimpairedMoveDown
xmap [e <Plug>unimpairedMoveUp
xmap ]e <Plug>unimpairedMoveDown

" Atajos para alinear hash de ruby y de javascript
" (requiere tabular, pero si pongo esta condición, no funciona)
" if exists(":Tabularize")
nmap <Leader>a> :Tabularize /=><CR>
vmap <Leader>a> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,\zs<CR>
vmap <Leader>a, :Tabularize /,\zs<CR>
" endif

" Ejemplo de Tim Pope: autoalinear tablas de cucumber (funciona sólo si partes
" de tabla ya alineada :S)
" inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a
" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction

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

"Muestra el número de línea
" set number
" Muestra el número de línea al final de la pantalla (ya estaba activo por
" defecto)
set ruler
" Indica que una línea es continuación de la anterior
set showbreak=...

" Recupera la línea del fichero en la que estaba la última vez que se editó
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" Graba automáticamente la sesión al salir
autocmd VimLeavePre *.rb,*.haml,*.sass,*.scss,*.coffee,*.yml,*.rake,Gemfile* mksession! ~/.vimsess
" Recupera la sesión grabada
nm <C-L> :source ~/.vimsess<CR>
" Permite quitar el buffer de la ventana aunque no se haya grabado
set hidden
" Graba automáticamente el buffer.
" set autowriteall
" Graba todos los archivos al cambiar de aplicación.
" TODO: posiblemente lo cambie a los archivos .sass
" autocmd BufLeave,FocusLost <silent> wall

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

" Permite contraer líneas basándose en la indentación
set foldmethod=indent
" Por defecto, no contrae las líneas cuando carga un nuevo buffer
set nofoldenable
" Contrae/expande líneas
nm <Space> za
" Contrae/expande líneas recursivamente hasta el último padre o último hijo
nm <S-Space> zA
" Para contraer o expandir todo
nm <C-Space> zR
nm <C-S-Space> zM


" No expandir a la primera coincidencia de orden automáticamente al dar
" al tabulador, sino listar las posibles
" las opciones que más me gustan son list:longest y list:full
set wildmode=list:full

" Idioma y corrección ortográfica
nmap <silent> <leader>q :set spell!<CR>
set spelllang=es_es

" Abrir una hoja de estilos SASS
autocmd User Rails Rnavcommand sass app/assets/stylesheets -suffix=.sass
" Abrir un fichero Coffeescript
autocmd User Rails Rnavcommand coffee app/assets/javascripts -suffix=.coffee
" Ficheros de jasmine
autocmd User Rails Rnavcommand casmine spec/javascripts/ -glob=**/* -suffix=.coffee
" Fixtures de jasmine
autocmd User Rails Rnavcommand jfixtures spec/javascripts/fixtures -glob=**/* -suffix=.html
" Ficheros de apoyo de tests de integración
autocmd User Rails Rnavcommand support spec/requests/support -glob=**/* -suffix=.rb
" Factories
autocmd User Rails Rnavcommand factory test/factories -glob=**/* -suffix=.rb
" Decorators
autocmd User Rails Rnavcommand decorator app/decorators -glob=**/* -suffix=_decorator.rb
" Cells
autocmd User Rails Rnavcommand cell app/cells -glob=**/* -suffix=_cell.rb
" Cell views
autocmd User Rails Rnavcommand cview app/cells -glob=**/* -suffix=.haml

" Sintaxis con espacios
autocmd FileType * setlocal ts=2 sts=2 sw=2 tw=0 expandtab
" Atajo para llamar al depurador en Rails 3
ca Rdebug   Rdebugger 'script/rails server'

" Atajos para Rails
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

" Probar el archivo actual
let g:speckyRunSpecKey = "<Leader>rt"
let g:speckyWindowType = 1
let g:speckyRunSpecCmd = "rspec -r ~/.vim/bundle/specky/ruby/specky_formatter.rb -f SpeckyFormatter"


"vimdiff current vs git head (fugitive extension)
nnoremap <Leader>gd :Gdiff<cr>
"switch back to current file and closes fugitive buffer
nnoremap <Leader>gD :diffoff!<cr><c-w>h:bd<cr>
" atajos para Git
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>gc :Gcommit<cr>
nnoremap <Leader>gw :Gwrite<cr>
nnoremap <Leader>gr :Gread<cr>

" Resaltado de varias búsquedas.
" matchadd() priority -1 means 'hlsearch' will override the match.
function! DoHighlight(hlnum, search_term)
  call UndoHighlight(a:hlnum)
  if len(a:search_term) > 0
    let id = matchadd("hl".a:hlnum, a:search_term, -1)
    let g:matchadd_ids[a:hlnum] = id
  endif
endfunction

function! UndoHighlight(hlnum)
  silent! call matchdelete(g:matchadd_ids[a:hlnum])
endfunction

function! SetHighlight(hlnum, colour)
  if len(a:colour) > 0
    exe "highlight hl".a:hlnum." term=bold ctermfg=".a:colour." guifg=".a:colour
  endif
endfunction

let g:matchadd_ids = {}
call SetHighlight(1, 'red')
call SetHighlight(2, 'green')
call SetHighlight(3, 'yellow')
nnoremap <Leader>ma :<C-u>call DoHighlight(v:count1, expand("<cword>"))<CR>
nnoremap <Leader>md :<C-u>call UndoHighlight(v:count1)<CR>
nnoremap <Leader>mc :<C-u>call SetHighlight(v:count1, input("Enter colour: "))<CR>
