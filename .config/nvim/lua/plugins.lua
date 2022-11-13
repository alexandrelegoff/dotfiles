vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'neoclide/coc.nvim'
	
	use { 'junegunn/fzf', run = './install --bin', }

	use 'junegunn/fzf.vim'

	use 'neovim/nvim-lspconfig'

	use 'preservim/nerdtree'

	use 'bfrg/vim-cpp-modern'

	use 'EdenEast/nightfox.nvim'
end)

