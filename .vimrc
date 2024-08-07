""" Vundle """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

let g:airline_theme='deep_space'
" for the editor itself
Plugin 'gmarik/Vundle.vim'
Plugin 'ctrlp.vim'
" Plugin 'Solarized'
Plugin 'ack.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-dispatch'
" Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rvm'
" Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'
Plugin 'danro/rename.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'w0rp/ale'
Plugin 'thiagoalessio/rainbow_levels.vim'
Plugin 'slashmili/alchemist.vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'github/copilot.vim'

" for general text editing
Plugin 'tComment'
Plugin 'endwise.vim'
Plugin 'surround.vim'
Plugin 'abolish.vim'
Plugin 'majutsushi/tagbar'

" language specific
Plugin 'haskell.vim'
Plugin 'vim-coffee-script'
" Plugin 'ensime/ensime-vim'

Plugin 'tyrannicaltoucan/vim-deep-space'
Plugin 'jparise/vim-graphql'

call vundle#end()

""" Settings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set nocompatible
syntax on
set autoindent
set ruler
set number
set hlsearch
set incsearch
set nowrap
" set winwidth=83
set ignorecase
set smartcase
set noswapfile
set showcmd
set wildmode=list:longest,full
set tags=.tags

filetype plugin indent on
" solarized options
" let g:solarized_termtrans=1
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
"
" set background=light
" let g:solarized_termcolors=256    
" use solarized 256 fallback
" colorscheme solarized
" let g:rainbow_levels = [
"     \{'ctermfg': 2, 'guifg': '#859900'},
"     \{'ctermfg': 6, 'guifg': '#2aa198'},
"     \{'ctermfg': 4, 'guifg': '#268bd2'},
"     \{'ctermfg': 5, 'guifg': '#6c71c4'},
"     \{'ctermfg': 1, 'guifg': '#dc322f'},
"     \{'ctermfg': 3, 'guifg': '#b58900'},
"     \{'ctermfg': 8, 'guifg': '#839496'},
"     \{'ctermfg': 7, 'guifg': '#586e75'}]


set background=dark
set termguicolors
let g:deepspace_italics=1
colorscheme deep-space

" Leader space
let mapleader = "\<Space>"

" Allow backspacing over autoindent, eol and start of lines
set backspace=indent,eol,start

" Use ripgrep instead of ack
let g:ackprg = 'rg --vimgrep'
let g:ctrlp_user_command = 'rg --files %s'

" disable Ctrl+P caching
let g:ctrlp_use_caching = 0

nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }

" set vertical marker at col 80
" set colorcolumn=80
" highlight ColorColumn ctermbg=blac

" Actually set marker and column for git commits
autocmd FileType gitcommit set colorcolumn=73

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
function! PositionCursorFromViminfo()
  " Do not return caret position on git's COMMIT_EDITMSG
  if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g`\""
  endif
endfunction
autocmd BufReadPost * call PositionCursorFromViminfo()

:nnoremap { :tabprev<CR>   " Previous tab
:nnoremap } :tabnext<CR>   " Next tab

""" Sick functions and macros """""""""""""""""""""""""""""""""""""""""""""""""

map <leader>rl :RainbowLevelsToggle<cr>

" Open and reload vimrc
map <leader>vrc :edit $MYVIMRC<cr>
map <leader>vsrc :source $MYVIMRC<cr>:echo "VIMRC reloaded"<cr>

" Rename current file
map <leader>n :call RenameFile()<cr>

" RSpec let double - Convert bare word to let(:thing) { double(:thing) }
map <leader>rld Ilet(:<esc>wviwyA) { double(:<esc>pA) }<esc>

" Ruby binding pry - insert binding.pry on the line above
map <leader>rbp Orequire "pry"; binding.pry # DEBUG @holek<esc>

" Python interactive debug shell on the line above
map <leader>rpp Oimport code; code.interact(local=dict(globals(), **locals())) # DEBUG @holek<esc>

" Ruby tap and pry
map <leader>rtp o.tap { \|o\| "DEBUG @holek"; require "pry"; binding.pry }<esc>

" Ruby no pry - remove a binding.pry from the current file, hope it's the one you wanted
map <leader>rnp /binding.pry<cr>dd:noh

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

" Infer RSpec/Cubumber steps file for current file
function! InferSpecFile(filename)
    if a:filename =~ '^app'
      let spec_file = substitute(a:filename, '^app', 'spec', '')
      let path = substitute(spec_file, '\.rb', '_spec.rb', '')
    elseif a:filename =~ '^lib/'
      let spec_file = substitute(a:filename, '^lib', 'spec', '')
      let path = substitute(spec_file, '\.rb', '_spec.rb', '')
    elseif a:filename =~ '^features/' && a:filename =~ '\.feature$'
      let steps_file = substitute(a:filename, '^features', 'features/step_definitions', '')
      let path = substitute(steps_file, '\.feature', '_steps.rb', '')
    else
      let spec_file = 'spec/' . a:filename
      let path = substitute(spec_file, '\.rb', '_spec.rb', '')
    endif

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
au BufRead,BufNewFile {Gemfile,Guardfile,Rakefile,Vagrantfile,Thorfile,config.ru,Herdfile} set filetype=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown} set filetype=markdown

" Spell checking for text formats
au BufRead,BufNewFile *.txt,*.md,*.markdown,*.textile setlocal spell

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufNewFile,BufRead Herdfile.*.lock set ft=yaml
au BufNewFile,BufRead Oyafile set ft=yaml
au BufRead,BufNewFile Jenkinsfile set filetype=groovy
au BufRead,BufNewFile Dockerfile.* set filetype=Dockerfile

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
map <c-/> :TComment<cr>
map <leader>n :call RenameFile()<cr>

" Spell checking for text formats
au BufRead,BufNewFile *.txt,*.md,*.markdown,*.textile,*.feature setlocal spell
autocmd FileType gitcommit setlocal spell
" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Remove 80 char line from temporary windows
au BufReadPost quickfix exe "normal G"
au BufReadPost quickfix setlocal colorcolumn=0
