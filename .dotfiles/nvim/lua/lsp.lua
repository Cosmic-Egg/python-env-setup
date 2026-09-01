vim.pack.add {'https://github.com/neovim/nvim-lspconfig',
-- "https://github.com/mason-org/mason.nvim",
}

-- -- require("mason").setup()

-- -- enabled servers ---
-- vim.lsp.enable('ty')
-- vim.lsp.enable('ruff')
-- -- vim.o.autocomplete = true

-- lua/lsp.lua

local map = vim.keymap.set

-- ─────────────────────────────────────────────
-- LSP servers
-- ─────────────────────────────────────────────

vim.lsp.config("basedpyright", {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "standard",
            },
        },
    },
})

vim.lsp.config("ruff", {
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
    end,
})

-- vim.lsp.enable("basedpyright")
vim.lsp.enable('ty')
vim.lsp.enable("ruff")
vim.lsp.enable("lua_ls")

-- ─────────────────────────────────────────────
-- Diagnostics
-- ─────────────────────────────────────────────

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    severity_sort = true,
})

-- -- ─────────────────────────────────────────────
-- -- Navigation
-- -- ─────────────────────────────────────────────

-- map("n", "gd", vim.lsp.buf.definition, {
--     desc = "Go to definition",
-- })

-- map("n", "gr", vim.lsp.buf.references, {
--     desc = "Go to references",
-- })

-- map("n", "gi", vim.lsp.buf.implementation, {
--     desc = "Go to implementation",
-- })

-- map("n", "gy", vim.lsp.buf.type_definition, {
--     desc = "Go to type definition",
-- })

-- map("n", "K", vim.lsp.buf.hover, {
--     desc = "Hover documentation",
-- })

-- -- ─────────────────────────────────────────────
-- -- Actions
-- -- ─────────────────────────────────────────────

-- map("n", "<leader>r", vim.lsp.buf.rename, {
--     desc = "Rename symbol",
-- })

-- map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, {
--     desc = "Code action",
-- })

-- -- ─────────────────────────────────────────────
-- -- Diagnostic navigation
-- -- ─────────────────────────────────────────────

-- map("n", "]d", function()
--     vim.diagnostic.jump({ count = 1 })
-- end, {
--     desc = "Next diagnostic",
-- })

-- map("n", "[d", function()
--     vim.diagnostic.jump({ count = -1 })
-- end, {
--     desc = "Previous diagnostic",
-- })

-- map("n", "<leader>d", vim.diagnostic.open_float, {
--     desc = "Show diagnostic",
-- })
