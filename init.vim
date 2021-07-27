let g:syntastic_disabled_filetypes=['html']
"add shopt -s globstar to .bashrc for it to work ... flist -S300 **/*.c > fun.c
"Turn off Error highlighting in Documentation hover files
"hi Error NONE
let g:node_host_prog = expand('~/.nvm/versions/node/v14.16.0/bin/neovim-node-host')
syntax on
filetype plugin on
set jumpoptions+=stack
"for any of set options below search :help option_name to get more info
set number relativenumber cursorline nohls hidden noerrorbells
set expandtab smartindent nowrap smartcase noswapfile nobackup
set undofile incsearch termguicolors noshowmode lazyredraw
set guicursor=
set mouse=a
set tabstop=4
set shiftwidth=4
set undodir=~/.nvim/undodir
set scrolloff=0
set iskeyword+=-
set wildignore=*cache*
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set cmdheight=2
"set path+=.,,**,~/.nvim/**,/var/cache/apt/archives,/root/Music/gbench-3.5.0/**,/usr/include/**,/usr/local/include,./node_modules/**
set path+=.,,**
"set runtimepath+=/root/.nvim/plugged/LanguageClient-neovim
set clipboard+=unnamed,unnamedplus
set updatetime=60

set shortmess+=c
"retab
"set colorcolumn=80
"highlight ColorColumn ctermbg=0 guibg=lightgrey
set splitbelow
set splitright

call plug#begin('~/.nvim/plugged')
Plug 'psliwka/vim-smoothie'
Plug 'makerj/vim-pdf'                           "Pdf in vim
"Plug 'sillybun/vim-repl'                        "repls for shell,vimscript,perl,python...leader-r(open-repl) leader-e(send-line)
Plug 'justinmk/vim-sneak'                       "jumping aroud the file s{ab} ; up , down
Plug 'preservim/nerdcommenter'                  "Comment code <leader>cs   , uncomment <leader>cu
Plug 'tpope/vim-rsi'                            "jumping back and forth in line in ex mode...terminal like
Plug 'tpope/vim-fugitive'                       "git plugin
Plug 'vim-airline/vim-airline'                  "Make statusline pretty
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'                      "File Manager
Plug 'neovim/nvim-lspconfig'                    "Collection of common configurations for the Nvim LSP client
Plug 'nvim-lua/completion-nvim'                 "Autocompletion framework for built-in LSP
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'             "Extensions to built-in LSP, for example, providing type inlay hints
Plug 'mbbill/undotree'
Plug '9mm/vim-closer'                           "Closes bracker when u press enter on newline..nice
Plug 'mfussenegger/nvim-jdtls'                  "Needed for Java
Plug 'chrisbra/Colorizer'                       "Colorizer for css
Plug 'hrsh7th/nvim-compe'
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'jelera/vim-javascript-syntax'
call plug#end()

"colorscheme atom-dark-256

"Vimdiesels copy paste mappings
vnoremap <C-c> "+y
map <C-p> "+p

"Primegens dp void register thing...useful for deleting and pasting
vnoremap <leader>p "_dP

"Prettier
au FileType css,scss let b:prettier_exec_cmd = "prettier-stylelint"

nnoremap g3 :marks<CR>
nmap <C-Left> :!node %<CR>

"Autosave options
let g:auto_save = 1  " enable AutoSave on Vim startup
"let g:auto_save_silent = 1  " do not display the auto-save notification

" vim-airline
" Configure the Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#formatter = 'unique_tail'


"Map leaderkey to space
"Leader key is used in combination with other keys
let g:mapleader = " "
let loaded_matchparen = 1

"Source file after every write
nnoremap <leader>s :source %<CR>

nnoremap <leader>v :tabedit $MYVIMRC<CR>
nnoremap gp :!python3.8 -m pip install
"See what clients are attached to buffer
nnoremap <leader>b :lua print(vim.inspect(vim.lsp.buf_get_clients()))<CR>
nnoremap \p :lua print(vim.inspect(vim.lsp.get_active_clients()))<CR>
"See autocompletion trigger chars for server at hand
"nnoremap <leader>t :lua print(vim.inspect(vim.lsp.buf_get_clients()[1].server_capabilities.completionProvider.triggerCharacters))

" Send the text of a motion to the REPL
"nmap <leader>rs  <Plug>(ReplSend)
" Send the current line to the REPL
"nmap L <Plug>(ReplSendLine)<A-l><C-\><C-n><PageDown>?\n<CR><A-h>j
""" THIS WAS ON FOR OPENCOG nmap L <Plug>(ReplSendLine)<A-l><C-\><C-n>5<C-e>?\n<CR><A-h>j
"nmap <leader>rs_ <Plug>(ReplSendLine)
" Send the selected text to the REPL
" THIS WAS ON vmap H <Plug>(ReplSend)


"Sneak
let g:sneak#label = 1 "Enable index for vim-sneak awesome feature

"REPL
nnoremap <space>r :REPLToggle<CR>
let g:sendtorepl_invoke_key = "<space>e"

"Uncomment when working with OPENCOG
"tnoremap <Esc> <C-\><C-n>
"tnoremap <A-h> <C-\><C-n><C-w>h
"tnoremap <Up> <C-\><C-n>

"Find file under cursor line and go to def
map <leader>h <C-o>h
"check bottom of file for jumping buffer backwards
"map <leader>j :buffer #<CR>
"nnoremap <leader>k t"gf0
nnoremap <leader>l :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>i :lua vim.lsp.buf.declaration()<CR>

"substitute double quotes with single quotes
nnoremap <leader>' :s/'/"/g<CR>

function! GoToFile()
    let line=getline('.')
    for c in split(line, '\zs')
        if(c=='"')
          normal! t"gf0
          return
        endif
        if(c=="'")
          normal! t'gf0
          return
        endif
    endfor
endfunction

nnoremap <leader>k <cmd>call GoToFile()<CR>

"Buffer Navigation , use alt jk for code navigation
nnoremap gj :bprev<CR>
nnoremap gk :bnext<CR>

"Resising windows
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>9 :resize -5<CR>
nnoremap <leader>0 :resize +5<CR>
"autocmd BufEnter *.vue  :vertical resize 100


"Unconventional but useful
nnoremap gw :w<CR>
nnoremap gq :q<CR>
nnoremap gwq :wq<CR>
nnoremap gwqa :wq<CR>

map gb <C-o>
inoremap jj <esc>

noremap <A-i> A


" redraw window so search terms are centered
nnoremap n nzz2<C-e>
nnoremap N Nzz2<C-e>
map <leader>m zt
"Access copied content outside of vim when quiting
autocmd VimLeave * call system("xsel -ib", getreg('+'))

"NERDTree is awesome
map <leader>n :NERDTreeToggle<CR>
map \\ :NERDTreeToggle<CR>

let NERDTreeSortOrder=['\.c$']
let NERDTreeIgnore=['\.class','\.o','\.pyc$', '\~$'] "ignore files in NERDTree
let g:NERDTreeDirArrows=1
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"Keep NERDTree window size fixed..resizing other windows breaks this
autocmd VimEnter * NERDTree autocmd VimEnter * set winfixwidth

"set splits
"set splitright splitbelow

"Alt mapped-----------------------------------------------------------
noremap <A-s> :w<CR>
nnoremap <A-w> <C-W>w

"Pagin fix
nnoremap <A-h> <C-W>h
nnoremap <A-k> <PageUp><CR>2<C-y>
nnoremap <A-j> <PageDown><CR>2<C-e>
nnoremap <A-l> <C-W>l
nnoremap <PageDown> <PageDown>2<C-e>
nnoremap <PageUp> <PageUp>2<C-y>
nnoremap <C-Down> <PageDown>2<C-e>
nnoremap <C-Up> <PageUp>2<C-y>

nnoremap gh <C-W>w
nnoremap <Left> <C-W>h

autocmd FileType nerdtree nmap <buffer> <Left> h
" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree
" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * silent NERDTreeMirror

let g:NERDTreeMapJumpParent=get(g:,'NERDTreeMapJumpParent','h')
let g:NERDTreeMapActivateNode=get(g:,'NERDTreeMapActivateNode','l')


map <Right> <C-W>l<CR>
map <Right> <CR>

nnoremap gy0 :set nornu! nonu!
nnoremap gy1 :w \| !clear >> /dev/null 2>&1 && gcc % -o %:r;./%:r<CR>
nnoremap gy2 :w \| !clear >> /dev/null 2>&1 && gcc -S %;bat %:r.s
nnoremap gy3 :!flist %<CR>
nnoremap gy4 :w \| !clear >> /dev/null 2>&1 && python3.8 %
nnoremap gy5 :w \| !clear >> /dev/null 2>&1 && g++ % -o %:r; ./%:r
nnoremap gy6 :g/^def <CR>
nnoremap gy7 :!grep -v '[*/]' %
nnoremap <f2> :g/^func.*/<CR>
nnoremap gym :vimgrep typedef\\|extern % <CR> :vert 80 copen<CR>
"nnoremap gyn :cnext<CR>zz<C-W>w
"nnoremap gyN :cprev<CR>zz<C-W>w

"Open quickfix items with l no need to press enter key also keep cursor in
"quickfix list
nnoremap <leader>g :copen<CR>
augroup QuickFix
     au!
     au FileType qf map <buffer> l <CR>zz<C-W>w
     au FileType qf map <buffer> <space> 2<C-W>w

    "Quickfix history
    au FileType qf map <buffer> <leader>j :colder<CR>
    au FileType qf map <buffer> <leader>k :cnewer<CR>
augroup END

"Tabs - Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt

"Buffers - Go to buffer by b number..
noremap <leader>b1 :b1<CR>
noremap <leader>b2 :b2<CR>
noremap <leader>b3 :b3<CR>
noremap <leader>b4 :b4<CR>
noremap <leader>b5 :b5<CR>
noremap <leader>b6 :b6<CR>
noremap <leader>b7 :b7<CR>
noremap <leader>b8 :b8<CR>
noremap <leader>b9 :b9<CR>

"Delete window and buffer
nnoremap <leader>d :bd<CR>

"smooth-scrolling...Pay attention to CASING HERE
map <A-d> <C-D>
map <A-u> <C-U>
map <A-f> <C-F>
map <A-b> <C-B>

"count term nr of occurences  also g/searchterm
" map <leader>a :%s/searchterm//gn

"map <F10> :make
"set makeprg
"REMEMBER CSCOPE 1)run gentags(usr/local/bin) 2) KEYS C-] for definitions 3) C-Space s for (references)
"
"" Enable nvim-lsp as the default omnifunc globally:

set omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=menuone,noinsert,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 200
let g:compe.source_timeout = 300
let g:compe.resolve_timeout = 500
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:false
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.ultisnips = v:false

lua << EOF
lspconfig = require'lspconfig'
completion_callback = require'completion'.on_attach

    local system_name = "Linux"
    local sumneko_root_path = '/root/Music/LANG_SERVERS/lua-language-server'
    local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

    require('lspconfig').sumneko_lua.setup({
      cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
      -- An example of settings for an LSP server.
      --    For more options, see nvim-lspconfig
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
          },
        }
      },
      on_attach = custom_lsp_attach
    })

    require'lspconfig'.pyls.setup{
      on_attach=on_attach_vim,
        settings = {
          pyls = {
            plugins = {
              pycodestyle =  { enabled = false },
              pylint =  { enabled = false }
            }
          }
        }
    }

    require('lspconfig').perlls.setup{}
    require('lspconfig').vimls.setup{}
    require('lspconfig').vuels.setup{ on_attach=completion_callback, filetypes = {"vue"}, init_options = { config = { vetur = { completion = { autoImport = true }, } } } }

    require('lspconfig').bashls.setup{}
--    require('lspconfig').cssls.setup{}

-- require'lspconfig'.stylelint_lsp.setup{
--  settings = {
--    stylelintplus = {
      -- see available options in stylelint-lsp documentation
--    }
--  }
-- }


-- Enable (broadcasting) snippet capability for completion
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require('lspconfig').cssls.setup{
    capabilities = capabilities,
    cmd = {"vscode-css-language-server", "--stdio"},
    on_attach = on_attach,
    settings = {
      css = { validate = true },
      less = { validate = true },
      scss = { validate = true }
    },
    capabilities = {
         textDocument = {
             completion = {
                 completionItem = {
                     snippetSupport = true
                 }
             }
         }
    }
  }

    require('lspconfig').tsserver.setup{}
--    require('lspconfig').pyls.setup{}
    require('lspconfig').clangd.setup{}
--    require('lspconfig').gopls.setup{}
--    require('lspconfig').sumneko_lua.setup{}
    require('lspconfig').jsonls.setup{}
    require('lspconfig').bashls.setup{}
    require('lspconfig').dockerls.setup{}
    require('lspconfig').html.setup{}

EOF


" Code navigation shortcuts
"nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
"nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

"nnoremap gd :lua vim.lsp.buf.definition()<CR>
"nnoremap gD :lua vim.lsp.buf.declaration()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap gs :lua vim.lsp.buf.signature_help()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap ge :lua vim.lsp.buf.rename()<CR>
nnoremap <A-e> :lua vim.lsp.buf.hover()<CR>
nnoremap ga :lua vim.lsp.buf.code_action()<CR>
nnoremap g9 :lua vim.lsp.buf.document_symbol()<CR>
nnoremap g8 :lua vim.lsp.buf.workspace_symbol()<CR>


" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>


function! LspRename()
    call inputsave()
    let l:newname = input('Rename: ')
    call inputrestore()
    call luaeval('vim.lsp.buf.rename("'.l:newname.'")')
endfunction

nnoremap gn <cmd>call LspRename()<CR>

let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_enable_underline = 0
let g:diagnostic_auto_popup_while_jump = 0
let g:diagnostic_insert_delay = 0


let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require('jdtls').start_or_attach({ cmd = {'/root/.nvim/plugged/nvim-jdtls/java-lsp.sh'}, root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'})})
    " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()
  augroup end
endif


"python ls registering
"if executable('pyls')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'whitelist': ['python3.5','python3.8','python3.9'],
"        \ })
"endif

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"Autocomplete background nice
highlight Pmenu ctermbg=gray guibg=black

"Miscellaneous
autocmd BufEnter *.cxxtest :setlocal filetype=cpp
autocmd BufEnter *.cc :set filetype=cpp

"Vetur and vue related important
autocmd BufEnter * :set suffixesadd=.vue,.js,.sass,.scss,.css,.html

"FUNCTIONS
function! s:clean_up_whitespaces()
    let cursorpos = getcurpos()
    silent! %s/\_s*\%$//
    silent! %s/\s\+$//
    call setpos('.', cursorpos)
endfunction

augroup custom
    autocmd!
    " Strip out unwanted whitespaces
    autocmd BufWritePre * call <SID>clean_up_whitespaces()
augroup end

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('json', 'none', 'none', 'orange', 'none')
call NERDTreeHighlightFile('html', 'green', 'none', 'lightyellow', 'none')
call NERDTreeHighlightFile('css', 'yellow', 'none', 'cyan', 'none')
call NERDTreeHighlightFile('js', 'red', 'none', '#ffa500', 'none')


" Highlighting applied to floating window
highlight LspDiagnosticsErrorFloating guifg=#fb4934 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
highlight LspDiagnosticsWarningFloating guifg=#fabd2f gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
highlight LspDiagnosticsInfoFloating guifg=#83a598 gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
" Highlighting applied to code
highlight LspDiagnosticsUnderlineError guifg=NONE guibg=NONE guisp=#fb4934 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl
highlight LspDiagnosticsUnderlineWarning guifg=NONE guibg=NONE guisp=#fabd2f gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl
highlight LspDiagnosticsUnderlineInfo guifg=NONE guibg=NONE guisp=#83a598 gui=undercurl ctermfg=NONE ctermbg=NONE cterm=undercurl




" BUG TODO: If there is no previous buffer, will loop forever!  We could check
" to see if we don't move at all, then abort.
function! GoBackToRecentBuffer()
  let startName = bufname('%')
  while 1
    normal! 
    let nowName = bufname('%')
    if nowName != startName
      break
    endif
  endwhile
endfunction

" A bit much to override an important key?
"nnoremap <silent> <C-O> :call GoBackToRecentBuffer()<Enter>
" You can always use <C-I> if you need to go forwards again.
nnoremap <silent> <leader>j :call GoBackToRecentBuffer()<Enter>0
" You can use g; and g, to move between recent change points.
"" Only in GVim:
"nnoremap <silent> <C-BS> :call GoBackToRecentBuffer()<Enter>


function! SyntaxGroups()
    for id1 in synstack(line("."), col("."))
        let id2 = synIDtrans(id1)
        let name1 = synIDattr(id1, "name")
        let name2 = synIDattr(id2, "name")
        echo name1 " -> " name2
    endfor
endfunction

" Pick whatever mapping you want here
map <silent> <F7> :call SyntaxGroups()<CR>

"Makrs lowercase letters as Capital
nnoremap mh mH
nnoremap `h `H
nnoremap 'h 'H
nnoremap mj mh
nnoremap `j `J
nnoremap 'j 'J
nnoremap mk mK
nnoremap `k `K
nnoremap 'k 'K
nnoremap ml mL
nnoremap `l `L
nnoremap 'l 'L

"/usr/local/share/nvim/runtime/ftplugin/sass.vim
" let partial1 = substitute(a:file,"^\\~","node_modules/","")
function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = shellescape(s:uri, 1)
  echom s:uri
  if s:uri != ""
    silent exec "!xdg-open '".s:uri."'"
    :redraw!
  else
    echo "No URI found in line."
  endif
endfunction
map gx :call HandleURL()<cr>

nnoremap <F2> :vimgrep /<c-r><c-w>\:/j **/*\.scss <bar> :copen <CR>
nnoremap <F3> :vimgrep /\.<c-r><c-w>/j **/*\.vue <bar> :copen <CR>


function! SassIncludeExpr(file) abort
  let partial = substitute(a:file, '\%(.*/\|^\)\zs', '_', '')
  let partial1 = substitute(a:file,'\%(^\~\)', './node_modules/', '')
  echo partial1

  if !empty(findfile(partial1))
    return partial1
  endif

  if !empty(findfile(partial))
    return partial
  endif
  return a:file
endfunction
