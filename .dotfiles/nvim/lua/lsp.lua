vim.pack.add {'https://github.com/neovim/nvim-lspconfig',
-- "https://github.com/mason-org/mason.nvim",
}

-- require("mason").setup()

-- enabled servers ---
vim.lsp.enable('ty')
vim.lsp.enable('ruff')
-- vim.o.autocomplete = true

