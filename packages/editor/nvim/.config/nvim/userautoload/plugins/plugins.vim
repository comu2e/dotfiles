call plug#begin('~/.local/share/nvim/plugged')
Plug 'fatih/vim-go' 
Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
Plug 'racer-rust/vim-racer'
Plug 'simrat39/rust-tools.nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Shougo/neco-vim'
Plug 'davidhalter/jedi-vim'
Plug 'thinca/vim-quickrun'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/vim-lsp'
call plug#end()

