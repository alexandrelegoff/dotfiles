require('plugins')
require('lsp')
require('mason').setup()
require("mason-lspconfig").setup()

local Path = require('plenary.path')

require('dap').adapters.lldb  = {
	id = 'cppdbg',
	type = 'executable',
	command = "/home/alex/extension/debugAdapters/bin/OpenDebugAD7",
	miDebuggerPath = "/usr/bin/gdb",
}

require('dap').configurations.cpp = {
	{
		name = "Launch",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
}

require('tasks').setup({
	default_params = {
		cmake = {
		cmd = "cmake",
		build_dir =  tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')),
		build_type = "Debug",
		dap_name = "lldb",
		generator = "Unix Makefiles",
		args = {
			configure = {
				"-DCMAKE_EXPORT_COMPILE_COMMANDS=ON", '-G', "Unix Makefiles",
			},
		},
		},
	},
	save_before_run = true,
	params_file = ".tasks.json",
	dap_open_command = function() return require('dap').repl.open() end,
})

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.wo.relativenumber = true
vim.wo.number = true

-- setup must be called before loading
vim.cmd("colorscheme sonokai")

vim.api.nvim_set_keymap("n", "<S-b>", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<S-c>", ":lua require'dap'.continue()<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<S-s>", ":lua require'dap'.step_over()<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<S-i>", ":lua require'dap'.step_into()<CR>", { noremap = true } )

vim.api.nvim_set_keymap("n", "<S-h>", ":lua require('dap.ui.variables ').hover()<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<S-e>", ":lua require('dap.ui.widgets').eval()<CR>", { noremap = true } )

vim.api.nvim_set_keymap("n", "<C-l>", ":Buffers<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<C-p>", ":Files<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<C-f>", ":Rg ", { noremap = true } )
vim.api.nvim_set_keymap("n", "<S-x>", ":Task start cmake run<CR>", { noremap = true } )
vim.api.nvim_set_keymap("n", "<S-d>", ":Task start cmake debug<CR>", { noremap = true } )

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


