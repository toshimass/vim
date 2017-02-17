set nocompatible	"vim
set autoread		"Automatically read when file is changed.
set scrolljump=5	"Scroll height
set showcmd		"Display command
set showmode		"Display current mode
set mouse=i		"Mouse mode
set clipboard=unnamed	"Use Clipboard
set cursorline

"----- Auto command -----
au QuickfixCmdPost make,grep,mm copen

"----- Appearance -----
set showmatch			"Highlight corresponding
set number				"Display line number
set lazyredraw

"----- Search -----
set hlsearch			"Highlight searched words
set incsearch			"Incremental Search
"Cancel searched highlight
nnoremap <Esc><Esc> :<C-u>nohlsearch<Return>

"----- Indent -----
set cindent				"Automatically indent as current line.
set shiftwidth=8		"Tab size
set tabstop=8

""----- Completion -----
"set wildmenu
"set wildchar=<tab>

"----- Status line -----
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"----- Color Scheme -----
if &t_Co > 1
	syntax enable
endif
"colorscheme asu1dark
colorscheme blugrine
"colorscheme candycode
"colorscheme default
"colorscheme emacs
"colorscheme reloaded

"----- Buffer command -----
map <Left> :bprev<CR>
map <Right> :bnext<CR>

""Display unvisible characters
"set list
set lcs=tab:>.,eol:$,trail:_,extends:\

"------------------------------------
" vundle
"------------------------------------
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'SrcExpl'
Bundle 'neocomplcache'
Bundle 'taglist.vim'
Bundle 'unite.vim'

filetype plugin indent on

"------------------------------------
" unite.vim
"------------------------------------
" Start with insert mode.
let g:unite_enable_start_insert=0
" Buffer list
noremap <C-U><C-B> :Unite buffer<CR>
" File list
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" Recently used file list
noremap <C-U><C-R> :Unite file_mru<CR>
" Register list
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>
" File & Buffer list
noremap <C-U><C-U> :Unite buffer file_mru<CR>
" Show bookmarks
noremap <C-U><C-M> :Unite bookmark<CR>
" Add to bookmark
noremap <C-U><C-D> :UniteBookmarkAdd<CR>
" Quit unite when ESC is pressed twice.
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" Unite-grep
nnoremap <silent> ,ug :Unite grep:%:-iHRn<CR>


"------------------------------------
" neocomplcache
"------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'


"------------------------------------
" Taglist & Source Explorer
"------------------------------------

""The switch of the TagList
nnoremap <F5> :TlistToggle<CR>
""Move to list window when TagList open
let g:Tlist_GainFocus_On_ToggleOpen = 1

""The switch of the Source Explorer
nmap <F6> :SrcExplToggle<CR>

""Set the height of Source Explorer window
let g:SrcExpl_winHeight = 9

""Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 300

""Set 'Enter' key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<Enter>"

""Set 'Space' key for back from the definition context
let g:SrcExpl_gobackKey = "<Space>"

""In order to Avoid conflicts, the Source Explorer should know what plugins
""are using buffers. And you need add their bufname into the list below
""according to the command ':buffers!'
let g:SrcExpl_pluginList = [
	\ "__Tag_List__",
	\ "Source_Explorer"
\ ]

""Enable/Disable the local definition searching, and note that this is not
""guaranteed to work, the Source Explorer doesn't check the syntax for now.
""It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1

""Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0

""Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" create/update a tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

""Set '<F12>' key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F12>"

