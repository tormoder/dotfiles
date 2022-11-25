" --------------------------------------------------------------
"
" .vimrc
" tormod erevik lea
"
" (mostly modifactions of http://www.github.com/erikw/dotfiles)
"
" --------------------------------------------------------------



" vundle {
	
	let s:using_vundle = 1		" vundle will break default behaviour of spellfile. let others know when using vundle.
	set nocompatible		" be improved.
	filetype off 			" required!

	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" github {
		Plugin 'scrooloose/nerdtree'
		Plugin 'airblade/vim-gitgutter'
	"}

	call vundle#end()            " required
	filetype plugin indent on    " required
" }




" Environment {
	if v:version < 703
		echoerr 'WARNING: This vimrc is written for Vim >= v.703; this is' v:version
	endif
	let s:use_plugins=1				" Enable plugin references in this rc.
	set nocompatible				" Be IMproved. Should be first.
	set viminfo+=n~/.vim/viminfo			" Write the viminfo file inside the Vim directory.
	set undodir=~/.vim/undo/			" Collect history instead of having them in '.'.
	set tags+=./tags;/				" Look for tags in current directory or search up until found.
	set encoding=utf-8				" Use Unicode inside Vim's registers, viminfo, buffers ...
	set termencoding=utf-8
" }




" General {
	filetype plugin indent on			" File type specific features.
	syntax enable					" Syntax highlighting but keep current colors.
	"syntax on					" Use default colors for syntax highlighting.
	set mouse=a					" Enable mouse in all modes.
	set mousehide 					" Hide mouse after chars typed
	set viewoptions=folds,cursor,slash,unix		" What to save with mkview.
	set history=512					" Store much history.
	"set spell					" Enable spell highlighting and suggestions.
	set spellsuggest=best,10			" Limit spell suggestions.
	set spelllang=en_us				" Languages to do spell checking for.
	if exists("s:using_vundle")
		" Set spellfile dynamically.
		execute "set spellfile=" . "~/.vim/spell/" . matchstr(&spelllang, "[a-zA-Z][a-zA-Z]") . "." . &encoding . ".add"
	endif
	"set dictionary+=~/.vim/spell/*.dic		" Use custom dictionaries.
	"set dictionary+=/usr/share/dict/words		" Use system dictionary.
	"set thesaurus+=~/.vim/thesaurus/*		" Use a thesaurus file.
	"set complete-=k complete+=k			" Put the dictionaries in the normal completion set.
	set completeopt=longest,menu,preview		" Insert most common completion and show menu.
	set omnifunc=syntaxcomplete#Complete		" Omni completion.
	set shortmess=filmnrxtToOI    			" Abbreviate messages.
	set nrformats=alpha,octal,hex			" What to increment/decrement with ^A and ^X.
	set hidden					" Work with hidden buffers more easily.
	set sessionoptions-=options			" Don't store global and local variables when saving sessions.
	set undofile					" Save undo to file in undodir.
	set undolevels=2048				" Levels of undo to keep in memory.history.
	"set nomodeline					" Turn off possibly malicious Ex command execution.
	set ttyfast					" Smoother changes.
	set clipboard+=unnamed				" Use register "* instead of unnamed register.
	set timeoutlen=1500				" Timout (ms) for mappings and keycodes.
	if !has('gui_running')
		if !has('win32') && !has('win64')
			set term=$TERM       		" Make arrow and other keys work.
		endif
		if &l:term  =~ "screen.*"
			set ttymouse=xterm2		" Needed for mouse support inside GNU Screen.
		endif
	endif
	" Function keys {
		" Urxvt does not emit what Vim expects for the function keys.
		" This must be after "set term".
		if $TERMEMU  =~ ".*rxvt.*"
			set <F1>=[11~
			set <F2>=[12~
			set <F3>=[13~
			set <F4>=[14~
			set <F5>=[15~
			set <F6>=[17~
			set <F7>=[18~
			set <F8>=[19~
			set <F9>=[20~
			set <F10>=[21~
			set <F11>=[23~
			set <F12>=[24~
		end
	" }
" }



" UI {
	set background=dark
	if ( &term =~ "-256color" )
		set t_Co=256
		colorscheme miromiro
	elseif ( has('gui_running') )
		set t_Co=256
		colorscheme ir_black
		if has("gui_gtk2")
			set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Regular\ 10 
		elseif has("win32") || has("win64")
    			set guifont=Consolas:h11:cANSI
		endif
	elseif ( &term == "linux" )
		colorscheme miro8
	else	
		colorscheme elflord 
	endif

	set title						" Show title in console title bar.
	set number						" Show line numbers.
	set tabpagemax=32					" Upper limit on number of tabs.
	set showmode						" Show current mode in the last line.
	set backspace=indent,eol,start				" Make backspace work like expected.
	set linespace=0						" No line spacing.
	set showmatch						" Shortly jump to a matching bracket when match.
	set wildmenu						" Enable tab-completion menu.
	set wildmode=full					" Full completion.
	set wildignorecase					" Case insensitive filename completion.
	set scrolljump=5 					" Lines to scroll when cursor leaves screen.
	set scrolloff=3 					" Minimum lines to keep above and below cursor.
	set hlsearch						" Highlight search.
	set incsearch						" Incremental search.
	set ignorecase						" Case insensitive search.
	set smartcase						" Smart case search.
	set splitbelow						" Open horizontal split below.
	set splitright						" Open vertical split to the right.
	set foldenable						" Use folding.
	set showcmd						" Show incomplete commands in the lower right corner.
	set ruler						" Show current cursor position in the lower right corner.
	set laststatus=2					" Always show the status line.
	set nolist						" Don't show unprintable characters.
	set listchars=eol:$,tab:>-,trail:¬,extends:>,nbsp:. 	" Characters to use for list.
	set cursorline						" Highlight the current line.


" }

" Commands {
	" Write with extended privileges.
	command! Wsudo silent w !sudo tee % > /dev/null
" }

" Mappings {
	let mapleader = ","								" The key for <Leader>.
	noremap <silent> <Space> :silent noh<Bar>echo<CR> 				" Clear search matches highlighting.
	nmap <silent> <Leader>v :source $MYVIMRC<CR>					" Source vimrc.
	nmap <silent> <Leader>V :tabe $MYVIMRC<CR>					" Edit vimrc.
	nmap Y y$									" Consistency with C and D. Does not work with YankRing.

	" Insert one chracter.
	nmap <Space>i i_<Esc>r
	" Insert one chracter after the cursor.
	nmap <Space>a a_<Esc>r

	if &l:term  =~ "screen.*"
		noremap <silent> <C-x>x <C-x>						" Decrement for consistency with GNU Screen.
	endif

	nmap <S-tab> :bnext<CR>

	" Toggles {

		" Toggle spell with a language. {
		function! ToggleSpell(lang)
			if !exists("b:old_spelllang")
				let b:old_spelllang = &spelllang
				let b:old_spellfile = &spellfile
				if exists("s:using_vundle")
					let b:old_dictionary = &dictionary
				endif
			endif

			let l:newMode = ""
			if !&l:spell || a:lang != &l:spelllang
				setlocal spell
				let l:newMode = "spell"
				execute "setlocal spelllang=" . a:lang
				if exists("s:using_vundle")
					execute "setlocal spellfile=" . "~/.vim/spell/" . matchstr(a:lang, "[a-zA-Z][a-zA-Z]") . "." . &encoding . ".add"
				endif
				execute "setlocal dictionary=" . "~/.vim/spell/" . a:lang . "." . &encoding . ".dic"
				let l:newMode .= ", " . a:lang
			else
				setlocal nospell
				let l:newMode = "nospell"
				execute "setlocal spelllang=" . b:old_spelllang
				if exists("s:using_vundle")
					execute "setlocal spellfile=" . b:old_spellfile
				endif
				execute "setlocal dictionary=" . b:old_dictionary
			endif
			return l:newMode
		endfunction
		" }
		nmap <silent> <F9> :echo ToggleSpell("en_us")<CR>			" Toggle English spell.
		nmap <silent> <F10> :echo ToggleSpell("nb")<CR>				" Toggle Norwegian spell.

		" Toggle between static and relative line numbers. {
		function! ToggleLine()
			if &number
				set relativenumber
			else
				set number
			endif
		endfunction
		" }
		nmap <silent> <Leader>L :call ToggleLine()<CR>				" Toggle static/relative line numbering.

		" Toggle Cursor {
			function! HighlightNearCursor()
				if !exists("s:highlightcursor")
					match Todo /\k*\%#\k*/
					let s:highlightcursor=1
				else
					match None
					unlet s:highlightcursor
				endif
			endfunction
		" }
		nmap <silent> <Leader>j :call HighlightNearCursor()<CR>			" Toggle highlight on cursor-word.

		" Toggle mouse {
			function! ToggleMouse()
				if &mouse == "a"
					set mouse=
				else
					set mouse=a
				endif
				set mouse?
			endfunction
		" }
		nmap <Leader>m :call ToggleMouse()<CR>					" Toggles mouse on and off.
	" }

" }



" Plugins {
if s:use_plugins
	" NERDTree {
		noremap <silent> <F2> :NERDTreeToggle<CR>	" Toggle the NERDTree file browser.
		let g:NERDTreeCaseSensitiveSort=1		" Sort case sensitive.
		let g:NERDTreeMouseMode=3			" Single click opens folders and files.
		let g:NERDTreeQuitOnOpen=1			" Close tree after open.
	" }
endif
" }


" Source local {
	if filereadable(expand("~/.vimrc.local"))
		source ~/.vimrc.local
	endif
" }
