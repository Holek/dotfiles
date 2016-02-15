""" Vundle """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" for the editor itself
Plugin 'gmarik/Vundle.vim'
Plugin 'Solarized'
Plugin 'ctrlp.vim'
Plugin 'ack.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rvm'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'danro/rename.vim'

" for general text editing
Plugin 'tComment'
Plugin 'endwise.vim'
Plugin 'surround.vim'
Plugin 'abolish.vim'

" language specific
Plugin 'haskell.vim'
Plugin 'vim-coffee-script'

call vundle#end()
filetype plugin indent on

""" Settings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
syntax on
set autoindent
set ruler
set number
set hlsearch
set incsearch
set nowrap
set winwidth=83
set ignorecase
set smartcase
set noswapfile
set showcmd
set wildmode=list:longest,full
set tags=.tags

" Leader space
let mapleader = "\<Space>"

" Allow backspacing over autoindent, eol and start of lines
set backspace=indent,eol,start

" solarized options
if !has('gui_running')
    let g:solarized_termtrans=1
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
endif
colorscheme solarized
set background=light
set t_Co=256                        " force vim to use 256 colors
let g:solarized_termcolors=256      " use solarized 256 fallback

" disable Ctrl+P caching
let g:ctrlp_use_caching = 0

" set vertical marker at col 80
set colorcolumn=80

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" visual bell http://vim.wikia.com/wiki/Disable_beeping
" set noerrorbells visualbell t_vb=
" autocmd GUIEnter * set visualbell t_vb=

" http://vimcasts.org/episodes/tabs-and-spaces/
set ts=2 sts=2 sw=2 expandtab

" from http://robots.thoughtbot.com/post/48275867281/vim-splits-move-faster-and-more-naturally
"open splits to the right and towards the bottom
set splitbelow
set splitright

" unobtrusive whitespace highlighting
" http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Return to last edit position when opening files
if has("autocmd")
  function! PositionCursorFromViminfo()
    " Do not return caret position on git's COMMIT_EDITMSG
    if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$")
      exe "normal! g`\""
    endif
  endfunction
  autocmd BufReadPost * call PositionCursorFromViminfo()
endif

:nnoremap { :tabprev<CR>   " Previous tab
:nnoremap } :tabnext<CR>   " Next tab

""" Sick functions and macros """""""""""""""""""""""""""""""""""""""""""""""""

" Open and reload vimrc
map <leader>vrc :edit $MYVIMRC<cr>
map <leader>vsrc :source $MYVIMRC<cr>:echo "VIMRC reloaded"<cr>

" Rename current file
map <leader>n :call RenameFile()<cr>

" RSpec let double - Convert bare word to let(:thing) { double(:thing) }
map <leader>rld Ilet(:wviwyA) { double(:pA) }

" Ruby binding pry - insert binding.pry on the line above
map <leader>rbp Orequire "pry"; binding.pry # DEBUG @bestie

" Ruby tap and pry
map <leader>rtp o.tap { \|o\| "DEBUG @bestie"; require "pry"; binding.pry }<esc>

" Ruby no pry - remove a binding.pry from the current file, hope it's the one you wanted
map <leader>rnp /binding.pry<cr>dd:noh

" Convert Ruby hash keys, works with visual selection
" Works with single quotes too.
map <leader>rhn :call RubyHashConvertStringKeysToNewSyntax()<cr>
map <leader>rho :call RubyHashConvertNewSyntaxKeysToStrings()<cr>
map <leader>rh19 :call RubyHashConvertSymbolKeysToNewSyntax()<cr>

function! RubyHashConvertStringKeysToNewSyntax()
  normal ^xf=dwbr:j
endfunction

function! RubyHashConvertNewSyntaxKeysToStrings()
  normal I"f:i"lcl =>j
endfunction

function! RubyHashConvertSymbolKeysToNewSyntax()
  normal ^xf r:ldt j
endfunction

" Ruby hash old - converts 1.9 symbol hash syntax to double quoted string and hash rocket
map <leader>rho I"f:i"lcl =>j

" Ruby open spec
map <leader>ros :call EditFile(InferSpecFile(expand('%')))<cr>

" Run test, support all common Ruby test libs
map <leader>rt :ccl<cr>:w<cr>:call RunTest(expand('%'))<cr><cr>

" As above but only test on current line
map <leader>rtl :ccl<cr>:w<cr>:call RunTestAtLine(expand('%'), line("."))<cr><cr>
"
" Repeats one of the above, for when you've navigated away from the test file
map <leader>rr :ccl<cr>:w<cr>:call RepeatLastTest()<cr><cr>

function! RepeatLastTest()
  if exists("g:last_test")
    call RunTestCommand(g:last_test)
  else
    echo "No last test, <leader>rt to run this file."
  end
endfunction

" Run a test file at line (currently supports Ruby only)
function! RunTestAtLine(filename, line_number)
  let test_command = InferRubyTestCommand(a:filename)

  if strlen(test_command)
    let test_command_with_line = test_command . ":" . a:line_number
    call RunTestCommand(test_command_with_line)
  else
    echo "Not a recognized test '" . a:filename . "'"
  end
endfunction!

" Run a test file (currently supports Ruby only)
function! RunTest(filename)
  let test_command = InferRubyTestCommand(a:filename)

  if strlen(test_command)
    call RunTestCommand(test_command)
  else
    echo "Not a recognized test '" . a:filename . "'"
  end
endfunction

function! RunTestCommand(test_command)
  let g:last_test = a:test_command
  exec "Dispatch " . a:test_command
  " exec("!testrunner-client " . a:test_command)
endfunction

" Copy and paste from system clipboard
vmap <leader>y "+y
nmap <leader>y "+yy
map <leader>p "+p
nmap <leader>P "+P

" Infer and return corresponding command to run a Ruby test file
function! InferRubyTestCommand(filename)
    if a:filename =~ "\.feature$"
      let command  = "bundle exec cucumber --strict"
    elseif a:filename =~ "_spec\.rb$"
      let command = "bundle exec rspec"
    elseif a:filename =~ "_test\.rb$"
      let command = "bundle exec ruby -I test"
    else
      return ""
    end

    return command . " " . a:filename
endfunction

" Infer RSpec file for current file
function! InferSpecFile(filename)
    if a:filename =~ '^app'
      let spec_file = substitute(a:filename, '^app', 'spec', '')
    elseif a:filename =~ '^lib/'
      let spec_file = substitute(a:filename, '^lib', 'spec', '')
    else
      let spec_file = 'spec/' . a:filename
    endif

    let path = substitute(spec_file, '\.rb', '_spec.rb', '')

    return path
endfunction

" Rename current file thanks @samphippen
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" This probably isn't necessary but I have no idea what I'm doing
function! EditFile(filename)
  exec "e " . a:filename
endfunction


""" Key remaps (standard stuff) """""""""""""""""""""""""""""""""""""""""""""""

" %% For current directory thanks @squil
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Remap esc to jj in insert mode
inoremap jj <Esc>

" Remap esc to kj in insert mode
inoremap kj <Esc>

" http://vimcasts.org/episodes/show-invisibles/
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Turn search highlighting off
map <leader>/ :noh<CR>

" Save with CTRL-s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
:imap <c-s> <Esc><c-s>

:nnoremap <c-n> :bprevious<CR>:redraw<CR>:ls<CR>

""" Forgive """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disable entering EX mode by accident
map Q <Nop>

" You know what I meant
command! Q  q  " Bind :Q  to :q
command! W  w  " Bind :W  to :w
command! Wq wq " Bind :Wq to :wq
command! WQ wq " Bind :WQ to :wq

""" Things to disable when you're feeling masochistic / anti-social

" Disable backspace
" inoremap <BS> <Nop>
" Disable delete
" inoremap <Del> <Nop>

" disble arrow keys in insert, command mode
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

""" Syntax highlighting """""""""""""""""""""""""""""""""""""""""""""""""""""""

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Guardfile,Rakefile,Vagrantfile,Thorfile,config.ru} set filetype=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown} set filetype=markdown

" Spell checking for text formats
au BufRead,BufNewFile *.txt,*.md,*.markdown,*.textile setlocal spell

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

""" Plugin configs """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Activeate CtrlP with leader t
nnoremap <silent> <leader>t :ClearCtrlPCache<cr>\|:CtrlP<cr>
nnoremap <silent> <leader>e :ClearCtrlPCache<cr>\|:CtrlP<cr>
nnoremap <leader>p :CtrlPBuffer<cr>
nnoremap <leader><leader> :CtrlPBuffer<cr>
" ctrl-p working mode nearest git versioned ancestor
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|tmp'

" Command + / for commenting
map <D-/> :TComment<cr>
map <leader>n :call RenameFile()<cr>

""" MacVim specific """""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('gui_running')
" MacVim save on loss of focus
" autocmd BufLeave,FocusLost * silent! wall

" Intelligently switch between relative and absolute line number line number
" autocmd FocusLost * :set norelativenumber
" if mode() == 'i'
"   autocmd FocusGained * :set relativenumber
" endif
" autocmd InsertEnter * :set norelativenumber
" autocmd InsertLeave * :set relativenumber
" autocmd CursorMoved * :set relativenumber
endif

" Spell checking for text formats
au BufRead,BufNewFile *.txt,*.md,*.markdown,*.textile,*.feature setlocal spell
autocmd FileType gitcommit setlocal spell
" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Remove 80 char line from temporary windows
au BufReadPost quickfix exe "normal G"
au BufReadPost quickfix setlocal colorcolumn=0
