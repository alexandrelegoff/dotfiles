vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'neoclide/coc.nvim'
	
	use { 'junegunn/fzf', run = './install --bin', }

	use 'junegunn/fzf.vim'

	use 'preservim/nerdtree'

	use 'bfrg/vim-cpp-modern'

	use 'nyoom-engineering/oxocarbon.nvim'

	use 'zchee/deoplete-jedi'

	use 'sainnhe/sonokai'

	use({
    	"iamcco/markdown-preview.nvim",
    	run = function() vim.fn["mkdp#util#install"]() end,
	})

	use { "mfussenegger/nvim-jdtls", ft = { "java" } }

	use {
    	"williamboman/mason.nvim",
    	"williamboman/mason-lspconfig.nvim",
    	"neovim/nvim-lspconfig",
	}

end)

