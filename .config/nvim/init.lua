require('plugins')
require('lsp')

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.wo.relativenumber = true
vim.wo.number = true

vim.cmd("colorscheme nightfox")

require('nightfox').setup({
	options = {
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		}
	}
})

vim.api.nvim_set_keymap("n", "<C-b>", ":Buffers<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<C-p>", ":Files<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<C-f>", ":Rg ", { noremap = true } )

vim.api.nvim_set_keymap("n", "<C-t>", ":NERDTree<CR>", { noremap = true } )

vim.api.nvim_set_keymap("n", "gn", ":bn<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "gp", ":bp<CR>", { noremap = true } )

vim.cmd([[

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

]])


