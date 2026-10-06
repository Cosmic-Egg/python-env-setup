local option = vim.opt
local keymap = vim.keymap
local lsp = vim.lsp
vim.g.mapleader = " "

-- Options --
option.number = true
option.relativenumber = true
option.scrolloff = 10
option.ignorecase = true
option.smartcase = true
option.inccommand = 'split' -- opens command action preview in temp split 
option.signcolumn = 'yes'
vim.cmd.colorscheme('catppuccin')
-- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })

-- Keymaps --
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap.set({ "n", "x" }, "gs", "^", {
    desc = "Go to first non-blank",
})

keymap.set({ "n", "x" }, "gl", "$", {
    desc = "Go to end of line",
})

keymap.set({ "n", "x" }, "gh", "0", {
    desc = "Go to end of line",
})

keymap.set("n", "ge", "G", {
    desc = "Go to end of file",
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
  desc = "Show diagnostic",
})


-- LSP --
vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}
lsp.enable('ruff')
lsp.enable('ty')

-- Autocommands --
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--         vim.o.signcolumn = 'yes:1'
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--         if client:supports_method('textDocument/completion') then
--             vim.o.complete = 'o,.,w,b,u'
--             vim.o.completeopt = 'menu,menuone,popup,noinsert'
--             vim.lsp.completion.enable(true, client.id, args.buf)
--         end
--     end
-- })


-- vim.opt.completeopt = { 'menu', 'menuone', 'popup', 'noinsert' }
-- vim.opt.pumheight = 6
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--
--         if not client:supports_method('textDocument/completion') then
--             return
--         end
--
--         -- Trigger completion for things like `os.`
--         vim.lsp.completion.enable(true, client.id, args.buf, {
--             autotrigger = true,
--         })
--
--         -- Trigger completion when typing normal characters
--         vim.api.nvim_create_autocmd('TextChangedI', {
--             buffer = args.buf,
--             callback = function()
--                 local col = vim.fn.col('.') - 1
--                 local line = vim.fn.getline('.')
--                 local char = line:sub(col, col)
--
--                 if char:match('[%w_]') then
--                     vim.lsp.completion.get()
--                 end
--             end,
--         })
--     end,
-- })

-- Plugins --
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })
require('todo-comments').setup { signs = true }

require("mini.ai").setup()

require("mini.surround").setup()

require("mini.pairs").setup()

require("mini.comment").setup()

require("mini.bracketed").setup()

require("mini.files").setup()

require("mini.pick").setup()

require("mini.statusline").setup()

require("mini.extra").setup()

require("mini.tabline").setup()

option.pumheight = 6
require('mini.completion').setup()
-- require("mini.jump").setup()

require('mini.diff').setup()

local clue = require("mini.clue")

clue.setup({
    triggers = {
        -- Leader
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in navigation families
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        { mode = "n", keys = "z" },

        -- mini.surround
        { mode = "n", keys = "s" },
    },

    clues = {
        clue.gen_clues.builtin_completion(),
        clue.gen_clues.g(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers(),
        clue.gen_clues.square_brackets(),
        clue.gen_clues.windows(),
        clue.gen_clues.z(),
    },
})


--- Mini Icons ---
if vim.g.have_nerd_font then
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
end


