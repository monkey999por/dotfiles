" https://qiita.com/morikooooo/items/9fd41bcd8d1ce9170301

"文字コードをUFT-8に設定
set fenc=utf-8

" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" インデントはスマートインデント
set smartindent
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索語をハイライト表示
set hlsearch

" jjでescapeと同様の動作
inoremap <silent> jj <ESC>

syntax enable
