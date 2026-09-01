vim.g.mapleader = " "

-- lua/keymaps.lua

local map = vim.keymap.set

-- ─────────────────────────────────────────────
-- General
-- ─────────────────────────────────────────────

map("i", "jj", "<Esc>", {
    desc = "Exit insert mode",
})

map("n", "<Esc>", "<cmd>nohlsearch<CR>", {
    desc = "Clear search highlight",
})

map("n", "<leader>w", "<cmd>write<CR>", {
    desc = "Write file",
})

map("n", "<leader>q", "<cmd>quit<CR>", {
    desc = "Quit",
})

-- ─────────────────────────────────────────────
-- Helix-like goto navigation
-- ─────────────────────────────────────────────

map({ "n", "x" }, "gs", "^", {
    desc = "Go to first non-blank",
})

map({ "n", "x" }, "gl", "$", {
    desc = "Go to end of line",
})

map({ "n", "x" }, "gh", "0", {
    desc = "Go to end of line",
})

map("n", "ge", "G", {
    desc = "Go to end of file",
})

-- gg already goes to the start of the file in Neovim,
-- so there is no need to remap it.

-- ─────────────────────────────────────────────
-- Scrolling
-- ─────────────────────────────────────────────

map("n", "<C-d>", "<C-d>zz", {
    desc = "Half-page down",
})

map("n", "<C-u>", "<C-u>zz", {
    desc = "Half-page up",
})

-- ─────────────────────────────────────────────
-- Files / Pickers
-- ─────────────────────────────────────────────

map("n", "<leader>e", function()
    MiniFiles.open()
end, {
    desc = "File explorer",
})

map("n", "<leader>f", function()
    MiniPick.builtin.files()
end, {
    desc = "Find files",
})

map("n", "<leader>/", function()
    MiniPick.builtin.grep_live()
end, {
    desc = "Live grep",
})

map("n", "<leader>b", function()
    MiniPick.builtin.buffers()
end, {
    desc = "Buffers",
})


map("n", "<leader>?", function() MiniExtra.pickers.keymaps() end, { desc = 'Search keymaps' })

-- map("n", "<leader>bd", "<cmd>bdelete<CR>", {
--     desc = "Delete buffer",
-- })

-- [b / ]b and [d / ]d are handled by mini.bracketed.

-- ─────────────────────────────────────────────
-- Window navigation
-- ─────────────────────────────────────────────

map("n", "<C-h>", "<C-w>h", {
    desc = "Window left",
})

map("n", "<C-j>", "<C-w>j", {
    desc = "Window down",
})

map("n", "<C-k>", "<C-w>k", {
    desc = "Window up",
})

map("n", "<C-l>", "<C-w>l", {
    desc = "Window right",
})

map("n", "<leader>x", "<cmd>cclose<CR>", {
    desc = "Close quickfix",
})

-- ─────────────────────────────────────────────
-- Visual mode
-- ─────────────────────────────────────────────

map("x", "<", "<gv", {
    desc = "Indent left",
})

map("x", ">", ">gv", {
    desc = "Indent right",
})

-- ─────────────────────────────────────────────
-- LSP navigation
-- ─────────────────────────────────────────────

map("n", "gd", vim.lsp.buf.definition, {
    desc = "Go to definition",
})

-- map("n", "gr", vim.lsp.buf.references, {
--     desc = "Go to references",
-- })

vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "grx")


map("n", "gr", function()
    MiniExtra.pickers.lsp({ scope = "references" })
end)

map("n", "gi", vim.lsp.buf.implementation, {
    desc = "Go to implementation",
})

map("n", "gy", vim.lsp.buf.type_definition, {
    desc = "Go to type definition",
})

map("n", "<leader>k", vim.lsp.buf.hover, {
    desc = "Hover documentation",
})

-- ─────────────────────────────────────────────
-- LSP actions
-- ─────────────────────────────────────────────

map("n", "<leader>r", vim.lsp.buf.rename, {
    desc = "Rename symbol",
})

map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, {
    desc = "Code action",
})

map("n", "<leader>d", vim.diagnostic.open_float, {
    desc = "Show diagnostic",
})

-- ─────────────────────────────────────────────
-- LSP / Symbol pickers
-- ─────────────────────────────────────────────

map("n", "<leader>s", function()
    MiniExtra.pickers.lsp({
        scope = "document_symbol",
    })
end, {
    desc = "Document symbols",
})

map("n", "<leader>S", function()
    MiniExtra.pickers.lsp({
        scope = "workspace_symbol",
    })
end, {
    desc = "Workspace symbols",
})

-- ─────────────────────────────────────────────
-- Comments
-- ─────────────────────────────────────────────
map("n", "<leader>c", "gcc", {
    remap = true,
    desc = "Toggle comment",
})

map("x", "<leader>c", "gc", {
    remap = true,
    desc = "Toggle comment selection",
})


-- vim.keymap.set("i", "<C-c>", "<Esc>")
-- vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })

-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

-- vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
-- vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

-- -- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })
-- -- vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart config :restart)" })
