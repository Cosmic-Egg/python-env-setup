vim.pack.add { "https://github.com/neanias/everforest-nvim" }
require("everforest").setup({
  -- Your config here
 transparent_background_level = 2,
 ui_contrast = "high",
})
vim.cmd([[colorscheme everforest]])
