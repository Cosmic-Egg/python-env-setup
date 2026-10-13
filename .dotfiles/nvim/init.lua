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
-- option.inccommand = 'split' -- opens command action preview in temp split 
option.signcolumn = 'yes'
option.tabstop = 4
option.shiftwidth = 4
vim.cmd.colorscheme('catppuccin')
vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
option.winborder = 'rounded'
-- vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })

-- Keymaps --
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
keymap.set('n', '<leader>y', '<Plug>OSCYankOperator')
keymap.set('v', '<leader>y', '<Plug>OSCYankVisual')

keymap.set({ "n", "x" }, "gs", "^", {desc = "Go to first non-blank",})

keymap.set({ "n", "x" }, "gl", "$", {desc = "Go to end of line",})

keymap.set({ "n", "x" }, "gh", "0", {desc = "Go to end of line",})

keymap.set("n", "ge", "G", {desc = "Go to end of file",})

keymap.set("n", "<leader>e", vim.diagnostic.open_float, {desc = "Show diagnostic",})
keymap.set('n', '<leader>k', vim.lsp.buf.hover, { desc = 'LSP hover documentation' })

vim.keymap.set('n', '<leader>sf', function() require('fzf-lua').files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>sw', function() require('fzf-lua').live_grep() end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>sb', function() require('fzf-lua').buffers() end, { desc = 'Find buffers' })
vim.keymap.set('n', 'grr', function() require('fzf-lua').lsp_references() end, { desc = 'LSP references' })
vim.keymap.set('n', 'grd', function() require('fzf-lua').lsp_definitions() end, { desc = 'LSP definitions' })

-- keymap.set("n", "<leader>sf", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
-- keymap.set("n", "<leader>sw", function() MiniPick.builtin.grep({pattern = vim.fn.expand("<cword>")  }) end, { desc = "Grep word/Search word" })
--
-- keymap.set("n", "<leader>sg", function() MiniPick.builtin.grep_live({  }) end, { desc = "Grep" })
-- keymap.set("n", "<leader>sh", function() MiniPick.builtin.help() end, { desc = "Mini Help" })
--
-- keymap.set("n", "<leader>sd", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Picker Diagnostics" })
-- keymap.set("n", "<leader>sk", function() MiniExtra.pickers.keymaps() end, { desc = 'Search keymaps' })
-- keymap.set("n", "<leader>sb", function() MiniPick.builtin.buffers() end, { desc = "Mini Buffer Picker" })
--
-- vim.keymap.set('n', 'grr', function() MiniExtra.pickers.lsp({ scope = 'references' }) end, { desc = 'LSP references' })
-- vim.keymap.set('n', 'grd', function() MiniExtra.pickers.lsp({ scope = 'definition' }) end, { desc = 'LSP definitions' })
--
-- LSP --
vim.pack.add{
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}
lsp.enable('ruff')
lsp.enable('ty')

-- Autocommands --

-- Plugins --
vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
vim.pack.add({'https://github.com/ibhagwan/fzf-lua'})

require('fzf-lua').setup(
	{
    actions = {
        files = {
            ['ctrl-s'] = require('fzf-lua.actions').file_vsplit,
        },
    },
}
)
require('todo-comments').setup { signs = true }

require("mini.ai").setup()

require("mini.surround").setup()

require("mini.pairs").setup()

require("mini.comment").setup()

require("mini.bracketed").setup()

require("mini.statusline").setup()

require('mini.tabline').setup()

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

    window = {
        config = function()
            return {
                width = math.floor(vim.o.columns * 0.35),
                height = math.floor(vim.o.lines * 0.4),
            }
        end,
    },
})


--- Mini Icons ---
if vim.g.have_nerd_font then
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
end


