set encoding=utf-8
scriptencoding utf-8
" vimrc再読み込み時のautocmdの初期化を行う。複数autocmdが登録されることを無効化する
augroup vimrc
  autocmd!
augroup END
" ==================
" dein settings
" ==================
" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体がインストールされるディレクトリ
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:for_vim_toml = g:rc_dir . '/dein_for_vim.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  if !has('nvim')
    call dein#load_toml(s:for_vim_toml, {'lazy': 0})
  endif
  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" 削除可能なpluginがあったら削除
if 0 < len(dein#check_clean())
  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" ==================
" 色系
" ==================
" 行番号の色
" colorschemeの設定前に書くこと
"autocmd ColorScheme * highlight LineNr ctermfg=207
"カラースキーマを設定
" colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
" Include background fill colors
let g:dracula_colorterm = 0
"イタリック(斜め字体)非対応ターミナルの場合にカラーがおかしくなるので無効化
let g:dracula_italic = 0
colorscheme dracula

" ==================
" setting
" ==================
" 既存のファイルを開くときはとりあえず utf-8
set fileencodings=utf-8,cp932
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 最低でも上下に表示する行数
set scrolloff=5
" <C-a> や <C-x> で数値を増減させるときに8進数を無効にする
set nrformats-=octal

if has('nvim')
  " yankした内容をクリップボードと共有する
  set clipboard=unnamed
endif

" ==================
" 見た目系
" ==================
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化（フラッシュさせる)
" ※フラッシュが目障りなので無効化
" set visualbell
set vb t_vb=
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" カーソルが何行目の何列目に置かれているかを表示する
set ruler

" ==================
" indent settings
" ==================
filetype on
filetype plugin on
filetype indent on

au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
au BufRead,BufNewFile *.tsx set filetype=typescript.tsx

" ==================
" Tab系
" ==================
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2
" 改行した時に、同じレベルのインデントにする
set autoindent
" 個別indent設定
au FileType php setlocal expandtab shiftwidth=4 softtabstop=4
au FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" ==================
" 検索系
" ==================
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" <Leader>を<Space>(半角スペース)に置き換え
let g:mapleader = "\<Space>"
" :vimgrepや:grepや:Ggrepでも自動的にquickfix-windowを開くようにする
autocmd QuickFixCmdPost *grep* cwindow

" ==================
" mapping settings
" ==================
" jjでESC
inoremap jj <Esc>
" <C-L>でdeleteキー
inoremap <C-L> <DEL>
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 行末までをヤンク
nnoremap Y y$
" カーソル行を空行化
nnoremap cc 0D
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" ^/$の簡易入力
nnoremap H ^
nnoremap L $
" tabキーによるインデント変更
nmap <Tab> >>
nmap <S-Tab> <<
imap <Tab> <c-t>
imap <S-Tab> <c-d>
" コマンドモードで<C-p>を押したら入力中の文字で前方一致検索のコマンド履歴を辿る
cnoremap <C-p> <Up>
" ノーマルモードでスペースを3回押すと、カーソル下の単語がハイライト
nnoremap <silent> <Space><Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
" ↑とセットで使用。<Leader><Leader>r でカーソル下の単語をハイライトしながら置換を行う。
nmap <Leader><Leader>r <Space><Space><Space>:%s/<C-r>///g<Left><Left>
" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>
" +,-でも上下のウィンドウサイズ調整
if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif
" 現在開いているバッファを削除して直前のバッファに切り替える
nmap <leader>q :bprevious<CR>:bdelete #<CR>
" タブ間の移動
" タブがなく、バッファのみの場合はバッファ間を移動する
function! SwitchTabOrBuf(arg)
  let hasManyTabPage = 1 < tabpagenr('$') ? 1 : 0
  if a:arg == "n"
    if hasManyTabPage
      :tabn
    else
      :bn
    endif
  elseif a:arg == "p"
    if hasManyTabPage
      :tabp
    else
      :bp
    endif
  else
    echo "error, arg must be 'n' or 'p'!"
  endif
endfunction
"nnoremap <C-n> gt
"nnoremap <C-p> gT
nnoremap <silent> <C-n> :call SwitchTabOrBuf("n")<CR>
nnoremap <silent> <C-p> :call SwitchTabOrBuf("p")<CR>
" 検索
" vimgrep
nmap <Esc>f :vimgrep // *<left><left><left>
" 検索時に画面中央に持ってくる
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" 置換系
" <Leader>r で一括置換フォーマットを呼び出す。
nnoremap <Leader>r :%s///g<left><left><left>
" redo
nnoremap U <C-R>
" for nvim
if has('nvim')
  " To map <Esc> to exit terminal-mode: >
  tnoremap <Esc> <C-\><C-n>
endif
" ==================
" カスタムコマンド
" ==================
" .vimrc再読み込み
command! Refresh source $MYVIMRC | e
" neovimでもterminalを分割して開く
if has('nvim')
  command! -nargs=* Term split | terminal <args>
  command! -nargs=* Termv vsplit | terminal <args>
endif

" ==================
" vim plugin設定
" ==================
" ------------------
" ALE
" ------------------
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_linter_aliases = {
\   'jsx': ['css', 'javascript'],
\   'vue': ['vue', 'javascript'],
\}
let g:ale_linters = {
\   'jsx': ['stylelint', 'eslint'],
\   'vue': ['eslint', 'vls'],
\}
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
let g:ale_fix_on_save_ignore = {'markdown': ['trim_whitespace']}
" LSP機能を無効化する場合は1をセット
let g:ale_disable_lsp = 0
" typescriptのオートインポート機能を有効化(デフォルトは無効)
let g:ale_completion_tsserver_autoimport = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%]%code: %%s [%severity%]'
" ------------------
" vim-airline
" ------------------
" powerline系フォントを有効にする
let g:airline_powerline_fonts = 1
" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
" Separators can be configured independently for the tabline, so here is how you can define "straight" tabs:
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" タブに表示するファイル名フォーマット
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" ------------------
" NERDTree
" ------------------
" Make nerdtree look nice
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
" 隠しファイルをデフォルトで表示させる
let g:NERDTreeShowHidden=1
" ディレクトリをvimで開いた時、netrwで開く
let g:NERDTreeHijackNetrw = 0
" ------------------
" NERDTreeTabs
" ------------------
" <Leader> + n でNERDTreeTabsを開く
map <Leader>n <plug>NERDTreeTabsToggle<CR>
" ------------------
" easymotion
" ------------------
" 割当キーを押しやすいものだけに変更
let g:EasyMotion_keys='asdfjkoweriop'
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_smartcase = 1
" ------------------
" posva/vim-vue
" ------------------
" ファイルの途中からsyntaxが効かなくなることがあるらしいので以下を追加
autocmd FileType vue syntax sync fromstart
" ------------------
" NERDCommenter
" ------------------
" .vueファイルのコメント機能を使用できるようにする。
" 参照: https://github.com/posva/vim-vue#nerdcommenter
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
" ------------------
" mhinz/vim-startify
" ------------------
" ファイル起動時、vcsのルートディレクトリに移動
let g:startify_change_to_vcs_root = 1
" リモートファイル関連の読込が遅くなる問題対策
let g:startify_skiplist = ['^/mnt/nfs']
let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc', '~/.bashrc', '~/dotfiles/', '~/Documents/accounts.md' ]
" ------------------
" nathanaelkane/vim-indent-guides
" ------------------
" Tab可視化色設定
hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'startify', 'fzf']
let g:indent_guides_default_mapping = 0
nmap <silent> <Leader>ig <Plug>IndentGuidesToggle
" ------------------
" Yggdroot/indentLine
" ------------------
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'startify', 'fzf']
" ------------------
" unblevable/quick-scope
" ------------------
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" ------------------
" terryma/vim-expand-region
" ------------------
" set mapping
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)
" ------------------
" reireias/vim-cheatsheet
" ------------------
let g:cheatsheet#cheat_file = '~/.vim/.cheatsheet.md'
" ------------------
" FZF
" ------------------
" popup(vim)またはfloating(nvim)でFZFを起動する
" popupまたはfloathinに対応しているバージョンの場合にだけ設定する
" nvim: 0.4以降, vim: 8.2以降
if has('nvim-0.4') || 802 <= v:version
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif
if executable('rg')
    command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg -S --line-number --no-heading --hidden --follow --glob "!.git" '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}, 'down:50%:wrap'))
endif
" RGコマンド (from :h fzf-vim)
" :Rgと異なり、検索ワードの再入力する為にコマンドを再実行する必要がない。
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --follow --glob "!.git" %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <Leader>p :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>g :Rg<Space>
nnoremap <Leader>G :RG<Space>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>f :History<CR>
nnoremap <Leader>c :BCommits<CR>
" :Files コマンドをpreview付きにする(batコマンドが使えれば色もつける)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
" :Buffers コマンドで該当バッファを開く際、既にウィンドウを開いていたらそのウィンドウに移動する
let g:fzf_buffers_jump = 1

" ------------------
" yuttie/comfortable-motion.vim
" ------------------
let g:comfortable_motion_interval = 3000.0 / 60
" ------------------
" GitGutter
" ------------------
" GitGutterのdiff取得感覚を100msecに変更(デフォルトは4000msec)
set updatetime=100
" ------------------
" ryanoasis/vim-devicons
" ------------------
" vimrc再読み込み時の問題対策
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
" ------------------
" Clap
" TODO:FZFで十分代用できるのでいらないかも。あとfloatingウィンドウが消えないバグがあって使いづらい
" ------------------
" file history (MRU)
"map <Leader>f :Clap history<CR>
" map <Leader>m :Clap marks<CR>
