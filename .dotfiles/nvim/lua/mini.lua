vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

-- lua/mini.lua

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

require("mini.jump").setup()

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


-- -- mini files ----
-- local MiniFiles = require("mini.files")
-- MiniFiles.setup({
--     mappings = {
--         go_in = "<CR>",
--         go_in_plus = "L",
--         go_out = "_",
--         go_out_plus = "H",
--     },
-- })

-- vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
-- vim.keymap.set("n", "<leader>-", function()
--     MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
--     MiniFiles.reveal_cwd()
-- end, { desc = "Toggle into currently opened file" })

-- --- mini picker ---
-- local MiniPick = require("mini.pick")
-- local MiniExtra = require("mini.extra")
-- MiniPick.setup()
-- MiniExtra.setup()
-- -- keymaps
-- vim.keymap.set("n", "<leader>sf", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
-- vim.keymap.set("n", "<leader>sw", function() MiniPick.builtin.grep({pattern = vim.fn.expand("<cword>")  }) end, { desc = "Grep word/Search word" })

-- vim.keymap.set("n", "<leader>sg", function() MiniPick.builtin.grep_live({  }) end, { desc = "Grep" })
-- vim.keymap.set("n", "<leader>sh", function() MiniPick.builtin.help() end, { desc = "Mini Help" })

-- vim.keymap.set("n", "<leader>sd", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Picker Diagnostics" })
-- vim.keymap.set("n", "<leader>sk", function() MiniExtra.pickers.keymaps() end, { desc = 'Search keymaps' })

-- --- Mini Icons ---
if vim.g.have_nerd_font then
	require('mini.icons').setup()
	MiniIcons.mock_nvim_web_devicons()
end

-- --- Mini Statusline ---
-- require('mini.statusline').setup({
-- 	use_icons = vim.g.have_nerd_font
-- })

-- --- Mini Clue ---
-- local miniclue = require('mini.clue')
-- miniclue.setup({
-- 	triggers = {
-- 		-- Leader triggers
-- 		{ mode = { 'n', 'x' }, keys = '<Leader>' },

-- 		-- `[` and `]` keys
-- 		{ mode = 'n', keys = '[' },
-- 		{ mode = 'n', keys = ']' },

-- 		-- Built-in completion
-- 		{ mode = 'i', keys = '<C-x>' },

-- 		-- `g` key
-- 		{ mode = { 'n', 'x' }, keys = 'g' },
-- 	},
-- 	clues = {
-- 		miniclue.gen_clues.g(),
-- 		miniclue.gen_clues.square_brackets(),
-- 		miniclue.gen_clues.builtin_completion(),
-- 		miniclue.gen_clues.windows(),
-- 		miniclue.gen_clues.z(),
-- 	},
-- })
-- --- Other Mini ---
-- require('mini.comment').setup()
-- require('mini.pairs').setup()
-- require("mini.surround").setup()
-- require("mini.ai").setup()
-- -- require("mini.completion").setup()
