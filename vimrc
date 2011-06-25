"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Tim Sims <tim.sims86 at gmail.com>
" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set history=500
if has('mouse')
	set mouse=a
endif
set backspace=indent,eol,start  "可以使用退格键删除文字
set ruler					    "显示光标所在位置
set rulerformat=%57(%50t[%{&ff},%Y]\ %m\ %l,%c\ %p%%%) 
set showcmd						"显示未输入完毕的命令
set incsearch					"搜索 
set	ignorecase smartcase 		"搜索时不区分大小写, 如果键入了大写字母则区分大小写.
set undolevels=1000				"设置撤销次数
set ve=all
set t_Co=256
map Q gq
inoremap <C-U> <C-G>u<C-U>

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif
call pathogen#runtime_append_all_bundles()

if has("autocmd")
	filetype plugin indent on
	augroup vimrcEx
		au!
		autocmd FileType text setlocal textwidth=78
		au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
	augroup END
else
	set autoindent		" always set autoindenting on
endif " has("autocmd")

if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Platform
function! MySys()
	if has("win32") || has("win64")
		return "windows"
	elseif has("mac")
		return "mac"
	else
		return "linux"
	endif
endfunction

"if MySys() == 'mac' || MySys() == 'linux'
"set shell=/bin/bash\ -l
"endif

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
" 新建文件使用的编码
set fileencoding=utf-8 
if MySys() == "windows"
	"source $VIMRUNTIME/vimrc_example.vim
	"source $VIMRUNTIME/mswin.vim
	"behave mswin
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

	" 解决菜单乱码
	set langmenu=zh_CN
	let $LANG = 'zh_CN.UTF-8'
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

" Move Backup Files to ~/.vim/backups/
if MySys() == 'mac' || MySys() == 'linux'

	set backupdir=~/.vim/backups
	set dir=~/.vim/backups
	set nobackup 
elseif MySys() == 'windows'
	set backupdir=D:\Vim\vimfiles\backups
	set dir=D:\Vim\vimfiles\backups
	set nobackup
endif
"set nowritebackup 

set shiftwidth=4
set tabstop=4
set wrap  

set wildmenu
set matchpairs=(:),{:},[:],<:>
set whichwrap=b,s,<,>,[,]
set foldmethod=syntax

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_running") || has("gui_macvim")
	colorscheme desertEx
	set rnu
	"desertEx
	let g:colors_name="desertEx"
else
	"colorscheme desertEx
	colorscheme evening
	set nu
endif

if MySys() == "mac"
	set guifont=Monaco:h12.5
	set guifontwide=Monaco:h12.5
elseif MySys() == "linux"
	set guifont=Monospace
else
	set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
	set gfw=Yahei_Mono:h10.5:cGB2312	
endif

set anti
set linespace=2 
"set rnu
set numberwidth=4
set equalalways
set guitablabel=%t

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype and syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:javascript_enable_domhtmlcss=1
let g:xml_use_xhtml = 1 "for xml.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")

	set columns=135
	set lines=58
	"winpos 250	42 

	"let macvim_skip_cmd_opt_movement = 1
	"let macvim_hig_shift_movement = 1

	set transp=2
	set guioptions-=T "egmrt
	""set guioptions+=b 

	"macm File.New\ Tab						key=<D-T>
	"macm File.Save<Tab>:w					key=<D-s>
	"macm File.Save\ As\.\.\.<Tab>:sav		key=<D-S>
	"macm Edit.Undo<Tab>u					key=<D-z> action=undo:
	"macm Edit.Redo<Tab>^R					key=<D-Z> action=redo:
	"macm Edit.Cut<Tab>"+x					key=<D-x> action=cut:
	"macm Edit.Copy<Tab>"+y					key=<D-c> action=copy:
	"macm Edit.Paste<Tab>"+gP				key=<D-v> action=paste:
	"macm Edit.Select\ All<Tab>ggVG			key=<D-A> action=selectAll:
	"macm Window.Toggle\ Full\ Screen\ Mode	key=<D-F>
	"macm Window.Select\ Next\ Tab			key=<D-}>
	"macm Window.Select\ Previous\ Tab		key=<D-{>
"else
	"set columns=120
	"set lines=58
	"winpos 250 35
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if MySys() == 'mac' || MySys() == 'linux'
	autocmd! bufwritepost .vimrc source ~/.vimrc
	autocmd! bufwritepost vimrc source ~/.vimrc
else
	autocmd! bufwritepost .vimrc source d:\vim\_vimrc
	autocmd! bufwritepost vimrc source d:\vim\_vimrc
endif

"let g:jslint_neverAutoRun=1

"autocmd BufRead * :lcd! %:p:h

" filetype
autocmd BufNewFile,BufRead *.vm setlocal ft=vim

"强制让文件使用自定义的colorscheme
autocmd BufNewFile,BufRead * call SetColorScheme() 
function! SetColorScheme() 
	execute ':colorscheme desertEx'
endfunction

" language support
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=79
filetype on " enables filetype detection filetype plugin on " enables filetype specific plugins
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.html set filetype=html
au! BufRead,BufNewFile *.json setfiletype json 
au BufRead,BufNewFile *.tpl set filetype=smarty 
au BufRead,BufNewFile *.lbi set filetype=html
au BufRead,BufNewFile *.pstpl set filetype=html

"设置字典
au FileType php call AddPHPFuncList()
function! AddPHPFuncList()
	if MySys() == 'mac' || MySys() == 'linux'
		set dictionary-=~/.vim/dict/php_funclist.txt dictionary+=~/.vim/dict/php_funclist.txt
	else
		set dictionary-=d:\vim\vimfiles\dict\php_funclist.txt dictionary+=~\.vim\dict\php_funclist.txt
	endif
	set complete-=k complete+=k
endfunction

autocmd FileType python set dictionary=~/.vim/dict/python.dict 
autocmd FileType javascript set dictionary=~/.vim/dict/javascript.dict
autocmd FileType css set dictionary=~/.vim/dict/css.dict

au Filetype smarty exec('set dictionary=~/.vim/syntax/smarty.vim') 
au Filetype smarty set complete+=k 


"Session auto-save/restore 
set sessionoptions+=resize,options
"autocmd VimEnter * call LoadSession()
"autocmd VimLeave * call SaveSession()
function! SaveSession()
			call SetColorScheme()
			execute 'mksession! ~/.vim/sessions/session.vim'
endfunction

function! LoadSession()
			call SetColorScheme()
			execute 'source ~/.vim/sessions/session.vim'
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! GetMySession(spath, ssname)
	if a:ssname == 0
		let a:sname = ""
	else
		let a:sname = "-".a:ssname
	endif
	execute "source $".a:spath."/session".a:sname.".vim"
	execute "rviminfo $".a:spath."/session".a:sname.".viminfo"
	execute "echo \"Load Success\: $".a:spath."/session".a:sname.".vim\""
endfunction

function! SetMySession(spath, ssname)
	if a:ssname == 0
		let a:sname = ""
	else
		let a:sname = "-".a:ssname
	endif
	execute "cd $".a:spath
	execute "mksession! $".a:spath."/session".a:sname.".vim"
	execute "wviminfo! $".a:spath."/session".a:sname.".viminfo"
	execute "echo \"Save Success\: $".a:spath."/session".a:sname.".vim\""
endfunction
" load session from path
command! -nargs=+ LOAD call GetMySession(<f-args>) 
" save session
command! -nargs=+ SAVE call SetMySession(<f-args>) 


" for make & debug

""function! QFSwitch() " toggle quickfix window
""	redir => ls_output
""		execute ':silent! ls'
""	redir END
""
""	let exists = match(ls_output, "[Quickfix List")
""	if exists == -1
""		execute ':copen'
""	else
""		execute ':cclose'
""	endif
""endfunction
""
""function! MyMake()
""	exe 'call ' . b:myMake . '()'
""endfunction
""
""function! MyLint()
""	exe 'call ' . b:myLint . '()'
""endfunction
""
""function! MyDebug()
""	exe 'call ' . b:myDebug . '()'
""endfunction
""
""function! MySetBreakPoint()
""	exe 'call ' . b:mySetBreakPoint . '()'
""endfunction
""
""function! MySetLog()
""	exe 'call ' . b:mySetLog. '()'
""endfunction
""
""function! MyRemoveBreakPoint()
""	exe 'call ' . b:myRemoveBreakPoint . '()'
""endfunction

"检查当前文件代码语法(php){{{
function! CheckPHPSyntax()
	if &filetype!="php"
		echohl WarningMsg | echo "Fail to check syntax! Please select the right file!" | echohl None
		return
	endif
	if &filetype=="php"
		" Check php syntax
		setlocal makeprg=\"php\"\ -l\ -n\ -d\ html_errors=off
		" Set shellpipe
		setlocal shellpipe=>
		" Use error format for parsing PHP error output
		setlocal errorformat=%m\ in\ %f\ on\ line\ %l
	endif
	execute "silent make %"
	set makeprg=make
	execute "normal :"
	execute "copen"
endfunction
map <F6> :call CheckPHPSyntax()<CR>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","
let g:mapleader=","

if MySys() == 'mac' || MySys() == 'linux'
	map <silent> <leader>ss :source ~/.vimrc<cr>
	map <silent> <leader>erc :e ~/.vimrc<cr>
	map <silent> <leader>rc :tabe ~/.vim/vimrc<cr>
else
	map <silent> <leader>ss :source d:\vim\_vimrc<cr>
	map <silent> <leader>erc :e d:\vim\_vimrc<cr>
	map <silent> <leader>rc :tabe d:\vim\_vimrc<cr>
endif
map <leader>q :q<cr>
"map <leader>qa :qa<cr>

"for make & debug
"noremap <F2> <ESC>:call MyLint()<CR>
"noremap <F3> :call MyDebug()<CR>
"noremap <F4> :call MyMake()<CR>
"noremap <F5> <ESC>:call QFSwitch()<CR>
"noremap <F6> :call MySetBreakPoint()<CR>
"noremap <F7> :call MySetLog()<CR>
"noremap <F8> :call MyRemoveBreakPoint()<CR>


nmap <tab> 		v>
nmap <s-tab> 	v<
vmap <tab> 		>gv 
vmap <s-tab> 	<gv

" map cmd to ctrl
if MySys() == "mac"
	set macmeta
	map <D-y> <C-y>
	map <D-e> <C-e>
	map <D-f> <C-f>
	map <D-b> <C-b>
	map <D-u> <C-u>
	map <D-d> <C-d>
	map <D-w> <C-w>
	map <D-r> <C-r>
	map <D-o> <C-o>
	map <D-i> <C-i>
	map <D-g> <C-g>
	map <D-a> <C-a>
	map <D-]> <C-]>
	cmap <D-d> <C-d>
	imap <D-e> <C-e>
	imap <D-y> <C-y>
endif

"设置alt快捷键
set winaltkeys=no

"快速保存
nmap <A-s> :w<CR>
imap <A-s> <Esc>:w<CR>i

"快速注释
imap <A-/> <Esc><C-h>i

"取消查找高亮
map <A-.> :nohlsearch<CR>
"imap <A-.> <Esc>

"删除当前行并重写
imap <A-r> <Esc>ddO   

"删除到行尾
imap <A-u> <Esc>wd$i

"删除光标处的单词
imap <A-w> <Esc>ebdei 

"插入上次删除的单词
imap <A-W> <C-R>w

"光标下插入新行
imap <A-O> <Esc>O
imap <A-o> <Esc>o

"制当前行
imap <A-y> <Esc>Ya

"粘贴到当前行
imap <A-v> <Esc>pi

"映射光标控制
imap <A-h> <Left>
imap <A-j> <Down>
imap <A-k> <Up>
imap <A-l> <Right>

"移动tabs
map <A-Right> <ESC>gt
map <A-Left> <ESC>gT

"删除光标处双引号之间的字符串
imap <A-i> <Esc>di"i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 

"bufExplorer setting
"let g:bufExplorerSortBy='mru'
"let g:bufExplorerSplitRight=0        " Split left.
"let g:bufExplorerSplitVertical=1     " Split vertically.
"let g:bufExplorerSplitVertSize = 30  " Split width
"let g:bufExplorerUseCurrentWindow=1  " Open in new window.
"let g:bufExplorerMaxHeight=25
"let g:bufExplorerResize=1
"autocmd BufWinEnter \[Buf\ List\] setl nonumber

" 默认键映射 <leader>bv :VSBufExplorer
"

" tasklist
"nmap <silent> <leader>tl :TaskList<CR>


" taglists setting
"""""""""""""""""""""""""""""" " Tag list (ctags) """""""""""""""""""""""""""""" 
if MySys() == "mac"
	let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
elseif MySys() == "linux" 
	let Tlist_Ctags_Cmd = '/usr/bin/ctags'
else
	let Tlist_Ctags_Cmd = 'd:\ctags\ctags.exe'
endif

nmap <silent> <leader>tg :TlistToggle<CR>
let list_Process_File_Always=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Close_On_Select = 1
let Tlist_Compact_Format=1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 30
let Tlist_Inc_Winwidth = 0
let Tlist_Show_One_File = 1

let g:tlist_javascript_settings = 'javascript;f:function;c:class;o:object;m:method;s:string;a:array;n:constant'


" NerdCommenter setting
let NERDShutUp=1
map <c-h> ,c<space>

let VCSCommandSVKExec='disabled no such executable'

"Use neocomplcache.
let g:NeoComplCache_EnableAtStartup = 1
"" Use smartcase.
let g:NeoComplCache_SmartCase = 1
"" Use camel case completion.
let g:NeoComplCache_EnableCamelCaseCompletion = 1
"" Use underbar completion.
let g:NeoComplCache_EnableUnderbarCompletion = 1 

" FuzzyFinder setting
nmap <leader>fb :FufBuffer<cr>
nmap <leader>ff :FufFile<cr>
nmap <leader>fd :FufDir<cr>
nmap <leader>fa :FufBookmark<cr>


inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 

"session
nmap <leader>mks :call SaveSession()<CR>
nmap <leader>lss :call LoadSession()<CR>

