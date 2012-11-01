"=============================================================================
"     FileName: .vimrc
"         Desc: 
"       Author: Tim Sims
"        Email: tim.sims86@gmail.com
"     HomePage: https://twitter.com/tim_si
"      Version: 0.0.1
"   LastChange: 2011-07-30 13:23:32
"      History:
"=============================================================================

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
if version >= 703
 set rnu
 set colorcolumn=80
else
 set nu
endif
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
		set clipboard+=unnamed
		return "windows"
	elseif has("mac")
		return "mac"
	else
		set clipboard=unnamedplus
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
	colorscheme molokai
	let g:colors_name="molokai"
else
	colorscheme molokai
endif

if MySys() == "mac"
	set guifont=Monaco:h13
	set guifontwide=Monaco:h13
elseif MySys() == "linux"
	set guifont=Monospace
else
	set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
	set gfw=Yahei_Mono:h10.5:cGB2312	
endif

set anti
set linespace=2 
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

	set columns=120
	set lines=53
	winpos 350	42 
	set transp=0
	set guioptions-=T "egmrt
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

" 自动切换工作目录
autocmd BufNewFile,BufRead,MenuPopup * :lcd! %:p:h

" filetype
autocmd BufNewFile,BufRead *.vm setlocal ft=vim

"强制让文件使用自定义的colorscheme
autocmd BufNewFile,BufRead * call SetColorScheme() 
function! SetColorScheme() 
	execute ':colorscheme molokai'
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
au BufRead,BufNewFile *.coffee set filetype=coffee
au BufWritePost *.coffee silent CoffeeMake!
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

"设置字典
au FileType php call AddPHPFuncList()
function! AddPHPFuncList()
	if MySys() == 'mac' || MySys() == 'linux'
		set dictionary-=~/.vim/dict/php_funclist.txt 
		set dictionary+=~/.vim/dict/php_funclist.txt
	else
		set dictionary-=d:\vim\vimfiles\dict\php_funclist.txt 
		set dictionary+=d:\vim\vimfiles\dict\php_funclist.txt
	endif
	set complete-=k complete+=k
endfunction

autocmd FileType python set dictionary=~/.vim/dict/python.dict 
autocmd FileType javascript set dictionary=~/.vim/dict/javascript.dict
autocmd FileType css set dictionary=~/.vim/dict/css.dict


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Session auto-save/restore 
set sessionoptions+=resize,options
function! SaveSession()
	call SetColorScheme()
	execute 'mksession! ~/.vim/sessions/session.vim'
endfunction
nmap <leader>mks :call SaveSession()<CR>

function! LoadSession()
	call SetColorScheme()
	execute 'source ~/.vim/sessions/session.vim'
endfunction
nmap <leader>lss :call LoadSession()<CR>


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


"检查当前文件代码语法(php){{{
function! CheckPHPSyntax()
	if &filetype!="php"
		echohl WarningMsg | echo "Fail to check syntax!  Please select the right file!" | echohl None
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

function! Phpcs()
	" phpcs 命令的路径和参数, 请根据环境自行修改
	! ~/pear/bin/phpcs --standard=Zend "%"
	cwindow
endfunction
" :w 自动验证语法
"autocmd BufWritePost *.php call Phpcs()
" :Phpcs 验证语法
"command! Phpcs execute Phpcs()

"单个文件编译
"进行make的设置
au BufNewFile,BufRead *.cpp,*.c,*.h map <F5> :call Do_OneFileMake()<CR>
au BufNewFile,BufRead *.cpp,*.c,*.h map <F6> :call Do_make()<CR>
au BufNewFile,BufRead *.cpp,*.c,*.h map <c-F6> :silent make clean<CR>
function! Do_make()
	set makeprg=make
	execute "silent make"
	execute "copen"
endfunction
function! Do_OneFileMake()
	if expand("%:p:h")!=getcwd()
		echohl WarningMsg | echo "Fail to make! This file is not in the \
		current dir! Press <F7> to redirect to the dir of this file." | echohl None
		return
	endif
	let sourcefileename=expand("%:t")
	if (sourcefileename=="" || (&filetype!="cpp" && &filetype!="c"))
		echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
		return
	endif
	let deletedspacefilename=substitute(sourcefileename,' ','','g')
	if strlen(deletedspacefilename)!=strlen(sourcefileename)
		echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
		return
	endif
	if &filetype=="c"
		if MySys() == "windows"
			set makeprg=gcc\ -o\ %<.exe\ %
		else
			set makeprg=gcc\ -o\ %<\ %
		endif
	elseif &filetype=="cpp"
		if MySys() == "windows"
			set makeprg=g++\ -o\ %<.exe\ %
		else
			set makeprg=g++\ -o\ %<\ %
		endif
		"elseif &filetype=="cs"
		"set makeprg=csc\ \/nologo\ \/out:%<.exe\ %
	endif
	if(MySys() == 'windows')
		let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'.exe','g')
		let toexename=outfilename
	else
		let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'','g')
		let toexename=outfilename
	endif
	if filereadable(outfilename)
		if(MySys() == 'windows')
			let outdeletedsuccess=delete(getcwd()."\\".outfilename)
		else
			let outdeletedsuccess=delete("./".outfilename)
		endif
		if(outdeletedsuccess!=0)
			set makeprg=make
			echohl WarningMsg | echo "Fail to make! I cannot delete the ".outfilename | echohl None
			return
		endif
	endif
	execute "silent make"
	set makeprg=make
	execute "normal :"
	if filereadable(outfilename)
		if(MySys() == 'windows')
			execute "!".toexename
		else
			execute "!./".toexename
		endif
	endif
	execute "copen"
endfunction

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

"""""""""""""""""""""""" " Tag list (ctags) """""""""""""""""""""""""""" 

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

"""""""""""""""""""""""""""""" " a.vim 		 """""""""""""""""""""""""""""" 


"""""""""""""""""""""""""""""" " NerdCommenter """""""""""""""""""""""""""""" 
nmap <leader>av :AV<cr>

" NerdCommenter setting
let NERDShutUp=1
map <c-h> ,c<space>


"""""""""""""""""""""""""""""" " FuzzyFinder """""""""""""""""""""""""""""" 

" FuzzyFinder setting
nmap <leader>fb :FufBuffer<cr>
nmap <leader>ff :FufFile<cr>
nmap <leader>fd :FufDir<cr>
nmap <leader>fa :FufBookmark<cr>
nmap <C-j> g:fuf_keyOpenSplit
nmap <C-k> g:fuf_keyOpenVsplit
nmap <C-l> g:fuf_keyOpenTabpage


"""""""""""""""""""""""""""""" " 	phpDoc 	 """""""""""""""""""""""""""""" 

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 

"""""""""""""""""""""""""""""" " 	PEP8 	 """""""""""""""""""""""""""""" 

"pep8.vim
let g:pep8_map='<F4>'

"""""""""""""""""""""""""""""" "   git-vim 	 """""""""""""""""""""""""""""" 

set laststatus=2

"""""""""""""""""""""""""""""" "   authorinfo 	 """""""""""""""""""""""""""""" 

let g:vimrc_author='Tim Sims' 
let g:vimrc_email='tim.sims86@gmail.com' 
let g:vimrc_homepage='https://twitter.com/tim_si' 


"""""""""""""""""""""""""""" "   ConqueTerm 	 """"""""""""""""""""""""""""""

let g:ConqueTerm_PyVersion = 2
let g:ConqueTerm_FastMode = 0
let g:ConqueTerm_Color = 1
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_Syntax = 'conque'
nmap <leader>bs :ConqueTermSplit bash<cr>
