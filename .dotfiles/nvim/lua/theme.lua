vim.pack.add { "https://github.com/neanias/everforest-nvim" }
require("everforest").setup({
  -- Your config here
 transparent_background_level = 2,
 ui_contrast = "high",
})
-- vim.cmd([[colorscheme everforest]])
-- vim.opt.termguicolors = false

-- vim.cmd("highlight clear")

-- vim.api.nvim_set_hl(0, "Normal",     { ctermfg = 7,  ctermbg = 0 })
-- vim.api.nvim_set_hl(0, "Comment",    { ctermfg = 8 })
-- vim.api.nvim_set_hl(0, "String",     { ctermfg = 2 })
-- vim.api.nvim_set_hl(0, "Function",   { ctermfg = 4 })
-- vim.api.nvim_set_hl(0, "Keyword",    { ctermfg = 5 })
-- vim.api.nvim_set_hl(0, "Type",       { ctermfg = 6 })
-- vim.api.nvim_set_hl(0, "Constant",   { ctermfg = 3 })
-- vim.api.nvim_set_hl(0, "Identifier", { ctermfg = 7 })
-- require("mini-base16")


vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"
vim.opt.winborder = "rounded"
-- require("colors").setup("sea")
vim.cmd([[colorscheme everforest]])
