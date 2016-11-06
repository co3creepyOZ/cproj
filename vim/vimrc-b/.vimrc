" To set up vim-plug on win32
" Powershell:
"
" md ~\vimfiles\autoload
" $uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" (New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\vimfiles\autoload\plug.vim")) 
"
"
set nocompatible " отключить режим совместимости с классическим Vi
syntax on
set number
set showcmd
set backspace=2

" set omnifunc=syntaxcomplete#Complete

colorscheme desert
set wrap " (no)wrap - динамический (не)перенос длинных строк
set linebreak " переносить целые слова
set mouse=a " включает поддержку мыши при работе в терминале (без GUI)
set autoread " перечитывать изменённые файлы автоматически
set mps+=<:> " показывать совпадающие скобки для HTML-тегов
set t_Co=256 " использовать больше цветов в терминале
set confirm " использовать диалоги вместо сообщений об ошибках
set laststatus=2 " всегда показывать строку состояния
set t_Co=256 " использовать больше цветов в eтерминале
set showcmd " показывать незавершенные команды в статусбаре (автодополнение ввода)

autocmd! bufwritepost $MYVIMRC source $MYVIMRC

"НАСТРОЙКИ РАБОТЫ С ФАЙЛАМИ
"Кодировка редактора (терминала) по умолчанию (при создании все файлы приводятся к этой кодировке)
if has('win32')
   set encoding=cp1251
else
   set encoding=utf-8
   set termencoding=utf-8
endif
set fileformat=unix
set fencs=utf-8,cp1251,koi8-r,cp866

set completeopt=menu,preview,longest

if has("gui_running")
	if has("gui_gtk2")
	   set guifont=Inconsolata\ 12
	elseif has("gui_macvim")
	    set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
	    set guifont=Consolas:h11:cANSI
	endif
endif

set ignorecase " ics - поиск без учёта регистра символов
set smartcase " - если искомое выражения содержит символы в верхнем регистре - ищет с учётом регистра, иначе - без учёта
set hlsearch " (не)подсветка результатов поиска (после того, как поиск закончен и закрыт)
set incsearch " поиск фрагмента по мере его набора
" поиск выделенного текста (начинать искать фрагмент при его выделении)
vnoremap <silent>* <ESC>:call VisualSearch()<CR>/<C-R>/<CR>
vnoremap <silent># <ESC>:call VisualSearch()<CR>?<C-R>/<CR>

"" Применять типы файлов
filetype on
filetype plugin on
filetype indent on

"НАСТРОЙКИ ОТСТУПА
set shiftwidth=4 " размер отступов (нажатие на << или >>)
set tabstop=4 " ширина табуляции
set softtabstop=4 " ширина 'мягкого' таба
set autoindent " ai - включить автоотступы (копируется отступ предыдущей строки)
set smartindent " Умные отступы (например, автоотступ после {)

"НАСТРОЙКИ ПЕРЕКЛЮЧЕНИЯ РАСКЛАДОК КЛАВИАТУРЫ
"" Взято у konishchevdmitry
set keymap=russian-jcukenwin " настраиваем переключение раскладок клавиатуры по <C-^>
set iminsert=0 " раскладка по умолчанию - английская
set imsearch=0 " аналогично для строки поиска и ввода команд
function! MyKeyMapHighlight()
   if &iminsert == 0 " при английской раскладке статусная строка текущего окна будет серого цвета
      hi StatusLine ctermfg=White guifg=White
   else " а при русской - зеленого.
      hi StatusLine ctermfg=DarkRed guifg=DarkRed
   endif
endfunction
call MyKeyMapHighlight() " при старте Vim устанавливать цвет статусной строки
autocmd WinEnter * :call MyKeyMapHighlight() " при смене окна обновлять информацию о раскладках
" использовать Ctrl+F для переключения раскладок
cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv

call plug#begin('~/.vim/plugged')
	
	Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
	Plug 'bling/vim-airline'
	Plug 'elzr/vim-json', { 'for': 'json' }
	Plug 'Shougo/vimproc'
	Plug 'Shougo/unite.vim'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'majutsushi/tagbar'
	Plug 'tpope/vim-surround'
	Plug 'mattn/emmet-vim'
	Plug 'scrooloose/syntastic'
	Plug 'DavidEGx/ctrlp-smarttabs'
	
	" Salesforce
	Plug 'neowit/vim-force.com'

call plug#end()

"НАСТРОЙКИ ГОРЯЧИХ КЛАВИШ
" F2 - сохранить файл
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

if has('win32')
	let g:tagbar_ctags_bin = 'C:\ctags58\ctags.exe'
endif

nmap <F11> :TagbarToggle<CR>

	" Проверка орфографии -->
        if version >= 700
            " По умолчанию проверка орфографии выключена.
            set spell spelllang=
            set nospell
            menu Spell.off :setlocal spell spelllang=<CR>:setlocal nospell<CR>
            menu Spell.Russian+English :setlocal spell spelllang=ru,en<CR>
            menu Spell.Russian :setlocal spell spelllang=ru<CR>
            menu Spell.English :setlocal spell spelllang=en<CR>
            menu Spell.-SpellControl- :
            menu Spell.Word\ Suggest<Tab>z= z=
            menu Spell.Add\ To\ Dictionary<Tab>zg zg
            menu Spell.Add\ To\ TemporaryDictionary<Tab>zG zG
            menu Spell.Remove\ From\ Dictionary<Tab>zw zw
            menu Spell.Remove\ From\ Temporary\ Dictionary<Tab>zW zW
            menu Spell.Previous\ Wrong\ Word<Tab>[s [s
            menu Spell.Next\ Wrong\ Word<Tab>]s ]s
        endif
    " Проверка орфографии <--

" C(trl)+d - дублирование текущей строки
imap <C-d> <esc>yypi
" Ctrl-пробел для автодополнения
inoremap <C-space> <C-x><C-o>
" C-e - комментировать/раскомментировать (при помощи NERD_Comment)
map <C-e> ,ci
nmap <C-e> ,ci
imap <C-e> <ESC>,cii
"" Вырезать-копировать-вставить через Ctrl
" CTRL-X - вырезать
vnoremap <C-X> "+x
" CTRL-C - копировать
vnoremap <C-C> "+y
" CTRL-V вставить под курсором
map <C-V>      "+gP
"" Отменить-вернуть через Ctrl
" отмена действия
noremap <C-Z> u
inoremap <C-Z> <C-O>u
" вернуть отменённое назад
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" F12 - обозреватель файлов (:Ex для стандартного обозревателя,
" плагин NERDTree - дерево каталогов)
map <F12> :NERDTreeToggle<cr>
vmap <F12> <esc>:NERDTreeToggle<cr>i
imap <F12> <esc>:NERDTreeToggle<cr>i
"" Переключение табов (вкладок) (rxvt-style)
map <S-left> :tabprevious<cr>
nmap <S-left> :tabprevious<cr>
imap <S-left> <ESC>:tabprevious<cr>i
map <S-right> :tabnext<cr>
nmap <S-right> :tabnext<cr>
imap <S-right> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>
nmap <S-down> :tabnew<cr>
imap <S-down> <ESC>:tabnew<cr>
nmap <S-w> :tabclose<cr>
imap <S-w> <ESC>:tabclose<cr>


"" Поиск выделенного текста (frantsev.ru/configs/vimrc.txt)
function! VisualSearch()
   let l:old_reg=getreg('"')
   let l:old_regtype=getregtype('"')
   normal! gvy
   let @/=escape(@@, '$.*/\[]')
   normal! gV
   call setreg('"', l:old_reg, l:old_regtype)
endfunction

""" Vim-force  -->
if has('win32') 
	let g:apex_workspace_path = "D:\\vim-force\\workspace"
	let g:apex_backup_folder = "D:\\vim-force\\backup"
	let g:apex_temp_folder = "D:\\vim-force\\temp"
	let g:apex_properties_folder = "D:\\vim-force\\properties"
	let g:apex_tooling_force_dot_com_path = "D:\\vim-force\\tools\\tooling-force.jar"
else
	let g:apex_workspace_path = "/home/creepyoz/vim-force/workspace"
	let g:apex_backup_folder = "/home/creepyoz/vim-force/backup"
	let g:apex_temp_folder = "/home/creepyoz/vim-force/temp"
	let g:apex_properties_folder = "/home/creepyoz/vim-force/properties"
	let g:apex_tooling_force_dot_com_path = "/home/creepyoz/vim-force/tooling-force/tooling-force.com.jar"
endif
runtime ftdetect/vim-force.com.vim

let g:apex_API_version = "36.0"

	" Бинд кнопок для удобной работы с vim-force -->
	" Модифицировать файл и сохранить в SFDC
	map <F5> :w<cr>:ApexSaveOne<cr>
	vmap <F5> <esc>:w<cr>:ApexSaveOne<cr>i
	imap <F5> <esc>:w<cr>:ApexSaveOne<cr>i
	
	" Обновить фаил с SDFC
	map <F6> :ApexRefreshFile<cr>
	vmap <F6> <cr>:ApexRefreshFile<cr>i
	imap <F6> <cr>:ApexRefreshFile<cr>i
	
		" menu items -->
		menu Apex.Init\ New\ Project :ApexInitProject<CR>
		menu Apex.Save.Save\ <F5> :w :ApexSaveOne<CR>
		menu Apex.Save.Save\ All\ Modified :w :ApexSave<cr>
		menu Apex.Refresh.Refresh\ File\ <F6> :ApexRefreshFile<cr>
		menu Apex.Refresh.Refresh\ Project :ApexRefreshProject<cr>
		" Deploy Items
		menu Apex.Deploy.Deploy :ApexDeploy<CR>
		menu Apex.Deploy.Deploy\ All :ApexDeployAll<CR>
		menu Apex.Deploy.Deploy\ Destructive :ApexDeployDestructive<cr>
		menu Apex.Deploy.Deploy\ All\ Destructive :ApexDeployAllDestructive<cr>
		menu Spell.-SpellControl- :
		menu Apex.Validate\ Tooling\ Force :ApexValidateJavaConfig

		" menu items end <--
	" <--


"" <--- vim-force end

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif

let NERDTreeIgnore = ['\-meta.xml$']

""" vim-json
let g:vim_json_syntax_conceal = 0
